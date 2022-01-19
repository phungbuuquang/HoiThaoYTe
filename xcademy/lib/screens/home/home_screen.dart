import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildTutorialView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Khoá học',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Xem thêm',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 15),
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouterName.detail_tutorial),
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
                      Text(
                        'Khoá tập huấn: Những kiến thức cơ bản trong sản xuất dây chuyền',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Đây là nội dung của khoá học',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Thứ sáu, 15 tháng 1, 2022',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.subtitleColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        animation: true,
                        lineHeight: 12,
                        animationDuration: 100,
                        percent: 0.7,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Theme.of(context).primaryColor,
                        backgroundColor: ColorConstant.dividerColor,
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
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
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://media.vov.vn/sites/default/files/styles/large/public/2021-01/d5_khyjueaavq7h_1.jpg',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Quang Phùng',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
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
