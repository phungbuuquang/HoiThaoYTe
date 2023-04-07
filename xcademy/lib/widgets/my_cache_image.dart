import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';

class MyCacheImage extends StatelessWidget {
  const MyCacheImage(
    this.imgUrl, {
    Key? key,
    this.fit,
    this.folder = AssetsFolder.icons,
    this.color,
    this.height,
    this.width,
    this.size,
    this.isCircle = false,
  }) : super(key: key);
  final String imgUrl;
  final AssetsFolder folder;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final bool isCircle;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (imgUrl.startsWith(IconsType.htttps.supportType())) {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => isCircle
            ? Container(
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
        fit: fit,
        imageUrl: imgUrl,
        color: color,
        width: width,
        height: height,
        placeholder: (context, url) => Container(
          height: height ,
          child: Center(
              child: CircularProgressIndicator(color: ColorConstant.primaryColor)),
        ),
        errorWidget: (context, url, error) => isCircle
            ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'assets/${AssetsFolder.images.getFolder()}/img_loading_error.png'),
                    fit: fit,
                  ),
                ),
              )
            : Image.asset(
                'assets/${AssetsFolder.images.getFolder()}/img_loading_error.png',
                fit: fit,
                height: height,
                width: width,
              ),
        cacheManager: CustomCacheManager.instance,
      );
    } else if (imgUrl.endsWith(IconsType.svg.supportType())) {
      return SvgPicture.asset(
        'assets/${folder.getFolder()}/$imgUrl',
        fit: fit ?? BoxFit.contain,
        color: color,
        height: height,
        width: width,
      );
    } else if (imgUrl.endsWith(IconsType.png.supportType())) {
      return Image.asset(
        'assets/${folder.getFolder()}/$imgUrl',
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    } else {
      return Image.asset(
        'assets/${AssetsFolder.images.getFolder()}/img_loading_error.png',
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}

enum IconsType { svg, png, htttps }

extension IconsTypeExt on IconsType {
  String supportType() {
    switch (this) {
      case IconsType.svg:
        return 'svg';
      case IconsType.png:
        return 'png';
      case IconsType.htttps:
        return 'https';
    }
  }
}

enum AssetsFolder { icons, images }

extension AssetsFolderExt on AssetsFolder {
  String getFolder() {
    switch (this) {
      case AssetsFolder.icons:
        return 'icons';
      case AssetsFolder.images:
        return 'images';
    }
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
    ),
  );
}
