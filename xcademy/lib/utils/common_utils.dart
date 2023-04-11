import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommonUtils {
  static showOkDialog(
    BuildContext context, {
    String? msg,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo"),
          content: Text(msg ?? ''),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showConfirmDialog(BuildContext context,
      {String? msg, Function()? okAction}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo"),
          content: Text(msg ?? ''),
          actions: [
            CupertinoDialogAction(
              child: Text("Huỷ bỏ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (okAction != null) {
                  okAction();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Widget circleIndicator(BuildContext context) {
    return CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
      strokeWidth: 3,
    );
  }

  static void showLoading() {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }
}
