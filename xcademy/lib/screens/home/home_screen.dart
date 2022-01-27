import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/home/bloc/home_bloc.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get _bloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _bloc.getNameUser();
      _bloc.getListSeminar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              _buildNavbarView(),
              SizedBox(
                height: 17,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTutorialView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialView() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) {
        return curr is HomeLoadingState || curr is HomeGetSeminarsDoneState;
      },
      builder: (_, state) {
        bool isLoading = false;
        List<SeminarModel> listItems = [];
        if (state is HomeLoadingState) {
          isLoading = true;
        } else if (state is HomeGetSeminarsDoneState) {
          listItems = state.listSeminars;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh sách hội thảo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // Text(
                  //   'Xem thêm',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w500,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : _buildListTutorialView(listItems)
          ],
        );
      },
    );
  }

  ListView _buildListTutorialView(List<SeminarModel> listItems) {
    return ListView.builder(
      itemCount: listItems.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 15),
      itemBuilder: (_, index) {
        final item = listItems[index];
        return _buildItemView(item);
      },
    );
  }

  InkWell _buildItemView(SeminarModel item) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(RouterName.detail_tutorial, arguments: item),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ColorConstant.dividerColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    image: item.AnhHoiThao ?? '',
                    placeholder: ImageConstant.placeholder,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 200),
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.LoaiHoiThao ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.TieuDe ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateUtil.strDatetoStr(item.NgayDienRa ?? ''),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Text(
            //   'Đây là nội dung của khoá học',
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
            // SizedBox(
            //   height: 5,
            // ),

            // SizedBox(
            //   height: 10,
            // ),
            // LinearPercentIndicator(
            //   animation: true,
            //   lineHeight: 12,
            //   animationDuration: 100,
            //   percent: 0.7,
            //   linearStrokeCap: LinearStrokeCap.roundAll,
            //   progressColor: Theme.of(context).primaryColor,
            //   backgroundColor: ColorConstant.dividerColor,
            // ),
          ],
        ),
      ),
    );
  }

  Container _buildNavbarView() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 15),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(20),
          //   child: Image.network(
          //     'https://media.vov.vn/sites/default/files/styles/large/public/2021-01/d5_khyjueaavq7h_1.jpg',
          //     fit: BoxFit.cover,
          //     width: 40,
          //     height: 40,
          //   ),
          // ),
          // SizedBox(
          //   width: 10,
          // ),
          BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (prev, curr) {
              return curr is ProfileLoadDoneState;
            },
            builder: (_, state) {
              String name = '';
              if (state is ProfileLoadDoneState) {
                name = state.user.HoTen ?? '';
              }
              return Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(RouterName.list_notification),
            child: SvgPicture.asset(IconConstant.bell),
          )
        ],
      ),
    );
  }
}
