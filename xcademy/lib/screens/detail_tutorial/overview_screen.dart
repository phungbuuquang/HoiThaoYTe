import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/screens/detail_tutorial/bloc/detail_seminar_bloc.dart';
import 'package:xcademy/screens/detail_tutorial/image_bill_dialog.dart';
import 'package:xcademy/utils/date_utils.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (_bloc.seminar.TieuDe ?? '').toUpperCase(),
                maxLines: null,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  image: _bloc.seminar.AnhHoiThao ?? '',
                  placeholder: ImageConstant.placeholder,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 200),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bắt đầu:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
              SizedBox(
                height: 16,
              ),
              _buildProgressView(),
              _buildListProgressView(),
            ],
          ),
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

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: isShowProgress ? listSubjects.length : 0,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final item = listSubjects[index];
            int percent = 0;
            if (item.TongThoiGianXem != null && item.TongThoiGianXem != '') {
              final timeCurr = double.parse(item.TongThoiGianXem!);
              final timeTotal = double.parse(item.ThoiLuongVideo!);
              percent = ((timeCurr / timeTotal) * 100.0).round();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
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
        );
      },
    );
  }

  Widget _buildProgressView() {
    return InkWell(
      onTap: () {
        if (!isShowProgress) {
          _bloc.getDetailSeminar();
        }
        setState(() {
          isShowProgress = !isShowProgress;
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
              'Tiến độ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Icon(
              isShowProgress ? Icons.expand_more_outlined : Icons.chevron_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
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
