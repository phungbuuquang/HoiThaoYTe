import 'package:flutter/cupertino.dart';

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
}
