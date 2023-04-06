import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyImage extends StatelessWidget {
  const MyImage(
    this.asset, {
    Key? key,
    this.typeFolder = TypeFolders.images,
    this.isSvg = true,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final String asset;
  final TypeFolders typeFolder;
  final bool isSvg;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return typeFolder == TypeFolders.remote
        ? Image.network(
            asset,
            width: width,
            height: height,
            fit: fit,
            color: color,
          )
        : isSvg
            ? SvgPicture.asset(
                typeFolder.path + asset,
                fit: fit,
                width: width,
                height: height,
                color: color,
              )
            : Image.asset(
                typeFolder.path + asset,
                width: width,
                height: height,
                fit: fit,
                color: color,
              );
  }
}

enum TypeFolders {
  icons,
  images,
  remote,
}

extension _TypeFoldersExt on TypeFolders {
  String get path {
    switch (this) {
      case TypeFolders.icons:
        return 'assets/icons/';
      case TypeFolders.images:
        return 'assets/images/';
      case TypeFolders.remote:
        return '';
    }
  }
}
