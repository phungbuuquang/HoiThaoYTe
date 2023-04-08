import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/widgets/my_image.dart';

import 'bloc/detail_seminar_bloc.dart';

class ListSubjectScreen extends StatefulWidget {
  const ListSubjectScreen({Key? key}) : super(key: key);

  @override
  _ListSubjectScreenState createState() => _ListSubjectScreenState();
}

class _ListSubjectScreenState extends State<ListSubjectScreen> {
  DetailSeminarBloc get _bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grayf5,
      body: _listSubjectView(),
    );
  }

  Widget _listSubjectView() {
    return BlocBuilder<DetailSeminarBloc, DetailSeminarState>(
      builder: (_, state) {
        bool isLoading = false;
        List<SubjectModel> listSubjects = [];
        if (state is DetailSeminarLoadingState) {
          isLoading = true;
        } else if (state is DetailSeminarGetSubjectsDoneState) {
          listSubjects = state.listSubjects;
        }
        return isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
              )
            : ListView.builder(
                itemCount: listSubjects.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                itemBuilder: (_, index) {
                  final item = listSubjects[index];
                  return _buildItemView(item);
                },
              );
      },
    );
  }

  Widget _buildItemView(SubjectModel item) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        RouterName.lession,
        arguments: item,
      ),
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 16,
          right: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: MyImage(
                'https://dytvr9ot2sszz.cloudfront.net/wp-content/uploads/2019/05/1200x628_logstash-tutorial-min.jpg',
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.TieuDe ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Trạng thái: ',
                            style: TextStyle(
                              color: ColorConstant.subtitleColor,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'Chưa hoàn thành',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
