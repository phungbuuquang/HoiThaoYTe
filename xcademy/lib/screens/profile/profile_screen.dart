import 'package:flutter/material.dart';
import 'package:xcademy/resources/color_constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Thông tin cá nhân'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                'https://media.vov.vn/sites/default/files/styles/large/public/2021-01/d5_khyjueaavq7h_1.jpg',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _buildInfoLabelView('Họ tên', 'Quang Phung'),
            SizedBox(
              height: 24,
            ),
            _buildInfoLabelView('Địa chỉ', 'Tp.HCM'),
            SizedBox(
              height: 24,
            ),
            _buildInfoLabelView('Ngày sinh', '02-04-1996'),
            SizedBox(
              height: 24,
            ),
            _buildInfoLabelView('Số điện thoại', '0379876212'),
            SizedBox(
              height: 24,
            ),
            _buildInfoLabelView('Email', 'phungbuuquang@gmail.com'),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: Center(
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildInfoLabelView(
    String title,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: ColorConstant.subtitleColor,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   height: 1,
        //   color: ColorConstant.dividerColor,
        // )
      ],
    );
  }
}
