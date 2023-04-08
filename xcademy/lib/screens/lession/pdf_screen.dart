import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xcademy/widgets/my_image.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 2,
        child: MyImage(url),
      ),
    );
  }
}
