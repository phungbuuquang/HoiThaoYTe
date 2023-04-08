import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/screens/detail_tutorial/bloc/detail_seminar_bloc.dart';
import 'package:xcademy/screens/detail_tutorial/image_bill_dialog.dart';
import 'package:xcademy/utils/date_utils.dart';
import 'package:xcademy/widgets/my_image.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  DetailSeminarBloc get _bloc => BlocProvider.of(context);
  bool isShowProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grayf5,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyImage(
              _bloc.seminar.AnhBia ?? '',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    blurRadius: 15,
                    color: ColorConstant.grayEAB.withOpacity(0.24),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (_bloc.seminar.TieuDe ?? '').toUpperCase(),
                    maxLines: null,
                    style: AppTextStyle.semibold18Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bắt đầu:',
                        style: AppTextStyle.regular14Gray,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          '${_bloc.seminar.ThoiGianBatDau}',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kết thúc:',
                        style: AppTextStyle.regular14Gray,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          '${_bloc.seminar.ThoiGianKetThuc}',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa điểm:',
                        style: AppTextStyle.regular14Gray,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          _bloc.seminar.DiaDiem ?? '',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildListProgressView(),
          ],
        ),
      ),
    );
  }

  Widget _buildListProgressView() {
    return BlocBuilder<DetailSeminarBloc, DetailSeminarState>(
      builder: (_, state) {
        List<SubjectModel> listSubjects = [];
        if (state is DetailSeminarLoadingState) {
          // isLoading = true;
        } else if (state is DetailSeminarGetSubjectsDoneState) {
          listSubjects = state.listSubjects;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 15,
                color: ColorConstant.grayEAB.withOpacity(0.24),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tiến độ',
                style: AppTextStyle.medium16Black,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: listSubjects.length,
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final item = listSubjects[index];
                  int percent = 0;
                  if (item.TongThoiGianXem != null &&
                      item.TongThoiGianXem != '') {
                    final timeCurr = double.parse(item.TongThoiGianXem!);
                    final timeTotal = double.parse(item.ThoiLuongVideo!);
                    percent = ((timeCurr / timeTotal) * 100.0).round();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${index + 1}.  ${item.TieuDe ?? ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$percent%',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaidView() {
    return BlocBuilder<DetailSeminarBloc, DetailSeminarState>(
        builder: (_, state) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ImageBillDialog(_bloc.seminar),
          ).then((value) {
            if (value != null) {
              _bloc.updateStatusBill();
            }
          });
        },
        child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _bloc.seminar.CoPhi == 'False'
                    ? 'Miễn phí'
                    : _bloc.seminar.AnhBienLai != ''
                        ? 'Đã có biên lai đóng phí'
                        : 'Chưa có biên lai đóng phí',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              _bloc.seminar.CoPhi == 'False'
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : _bloc.seminar.AnhBienLai != ''
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.report,
                          color: Colors.orange,
                        )
            ],
          ),
        ),
      );
    });
  }
}
