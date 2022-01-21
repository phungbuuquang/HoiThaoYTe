import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _bloc.getDetailSeminar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
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
          bottom: 15,
          left: 15,
          right: 15,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                'https://dytvr9ot2sszz.cloudfront.net/wp-content/uploads/2019/05/1200x628_logstash-tutorial-min.jpg',
                width: 120,
                height: 84,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.TieuDe ?? '',
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
            )
          ],
        ),
      ),
    );
  }
}
