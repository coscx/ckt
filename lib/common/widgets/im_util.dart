import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'chat_picture_preview.dart';

class IMUtil {
  IMUtil._();

  static Future<CroppedFile?> uCrop(String path) {
    return ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
    );
  }

  static Widget previewPic({
    required List<PicInfo> picList,
    int index = 0,
    String? tag,
  }) =>
      ChatPicturePreview(
        tag: tag,
        picList: picList,
        index: index,
        onDownload: (url) async {
          var appDocDir = await getTemporaryDirectory();
          var name = url.substring(url.lastIndexOf('/'));
          String savePath = appDocDir.path + name;
          print(savePath);

          return true;
        },
      );

  static bool isNotNullStr(String? str) => null != str && "" != str.trim();

  static Future<bool> isExitFile(String? path) async {
    return isNotNullStr(path) ? await File(path!).exists() : false;
  }

  static bool isMobile(String mobile) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  // md5 加密
  static String generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }

  static bool isNoEmpty(String? value) {
    return null != value && value.trim().isNotEmpty;
  }

  static String seconds2HMS(int seconds) {
    int h = 0;
    int m = 0;
    int s = 0;
    int temp = seconds % 3600;
    if (seconds > 3600) {
      h = seconds ~/ 3600;
      if (temp != 0) {
        if (temp > 60) {
          m = temp ~/ 60;
          if (temp % 60 != 0) {
            s = temp % 60;
          }
        } else {
          s = temp;
        }
      }
    } else {
      m = seconds ~/ 60;
      if (seconds % 60 != 0) {
        s = seconds % 60;
      }
    }
    if (h == 0) {
      return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
    }
    return "${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}";
  }

  ///  compress file and get file.
  static Future<File?> compressAndGetPic(File file) async {
    var path = file.path;
    var name = path.substring(path.lastIndexOf("/"));
    var targetPath = await createTempFile(fileName: name, dir: 'pic');
    CompressFormat format = CompressFormat.jpeg;
    if (name.endsWith(".jpg") || name.endsWith(".jpeg")) {
      format = CompressFormat.jpeg;
    } else if (name.endsWith(".png")) {
      format = CompressFormat.png;
    } else if (name.endsWith(".heic")) {
      format = CompressFormat.heic;
    } else if (name.endsWith(".webp")) {
      format = CompressFormat.webp;
    }

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 100,
      minWidth: 480,
      minHeight: 800,
      format: format,
    );
    return result;
  }

  static Future<String> createTempFile({
    required String dir,
    required String fileName,
  }) async {
    var path = (Platform.isIOS
            ? await getTemporaryDirectory()
            : await getExternalStorageDirectory())
        ?.path;
    File file = File('$path/$dir/$fileName');
    if (!(await file.exists())) {
      file.create(recursive: true);
    }
    return '$path/$dir/$fileName';
  }

  static int compareVersion(String val1, String val2) {
    var arr1 = val1.split(".");
    var arr2 = val2.split(".");
    int length = arr1.length >= arr2.length ? arr1.length : arr2.length;
    int diff = 0;
    int v1;
    int v2;
    for (int i = 0; i < length; i++) {
      v1 = i < arr1.length ? int.parse(arr1[i]) : 0;
      v2 = i < arr2.length ? int.parse(arr2[i]) : 0;
      diff = v1 - v2;
      if (diff == 0)
        continue;
      else
        return diff > 0 ? 1 : -1;
    }
    return diff;
  }
}
