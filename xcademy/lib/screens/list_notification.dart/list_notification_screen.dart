import 'package:flutter/material.dart';
import 'package:xcademy/resources/color_constant.dart';

class ListNotificationScreen extends StatefulWidget {
  const ListNotificationScreen({Key? key}) : super(key: key);

  @override
  _ListNotificationScreenState createState() => _ListNotificationScreenState();
}

class _ListNotificationScreenState extends State<ListNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
      ),
      body: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: ColorConstant.dividerColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nghẹt thở bảng xếp hạng Ngoại hạng Anh: MU đại thắng cách top 4 mấy điểm?',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Nghẹt thở bảng xếp hạng Ngoại hạng Anh: MU đại thắng cách top 4 mấy điểm?',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstant.subtitleColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '12 ngày trước ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
