import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:xcademy/utils/common_utils.dart';

class ImageBillDialog extends StatefulWidget {
  final SeminarModel seminar;
  ImageBillDialog(this.seminar);

  @override
  _ImageBillDialogState createState() => _ImageBillDialogState();
}

class _ImageBillDialogState extends State<ImageBillDialog> {
  late SeminarModel _seminar;
  XFile? _imagePicked;
  bool _isLoading = false;
  @override
  void initState() {
    _seminar = widget.seminar;
    super.initState();
  }

  save() async {
    if (_imagePicked == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final userId = injector.get<DataPrefs>().getUserId();
    final form = FormData.fromMap({
      'fileimg': MultipartFile.fromFileSync(
        _imagePicked?.path ?? '',
        contentType: MediaType.parse(lookupMimeType(_imagePicked!.path) ?? ''),
      ),
    });
    final res = await injector.get<ApiClient>().updateImageBill(
          userId,
          _seminar.idHoiThao ?? '',
          form,
        );
    if (res != null && res.data?.first.result == 'success') {
      Navigator.of(context).pop(true);
      return;
    }
    CommonUtils.showOkDialog(
      context,
      msg: ErrorConstant.default_error,
    );
  }

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    print(image);
    setState(() {
      _imagePicked = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 300,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _imagePicked != null
                    ? Image.file(
                        File(_imagePicked!.path),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    : _seminar.AnhBienLai == "" || _seminar.AnhBienLai == null
                        ? Text('Chưa cập nhật')
                        : FadeInImage.assetNetwork(
                            placeholder: ImageConstant.placeholder,
                            image: _seminar.AnhBienLai ?? '',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Chọn ảnh'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        onPressed: save,
                        child: _isLoading
                            ? CommonUtils.circleIndicator(context)
                            : Text('Lưu'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
