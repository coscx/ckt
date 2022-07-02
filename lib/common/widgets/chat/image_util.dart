import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ImageUtil {
  /*
  * 从相机取图片
  */
  static Future getCameraImage(BuildContext context) async {
    var assets =  await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(),
    );
    return assets;
  }
  static Future getCameraVideo(BuildContext context) async {
    var assets =  await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(
          enableRecording:true,
      ),
    );
    return assets;
  }
  /*
  * 从相册取图片
  */
  static Future getGalleryImage(BuildContext context) async {
    List<AssetEntity> asset = <AssetEntity>[];
    var assets =  await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        textDelegate: const AssetPickerTextDelegate(),
        maxAssets: 1,
        selectedAssets: asset,
        pickerTheme: AssetPicker.themeData(
          Colors.lightBlueAccent,
          light: true,
        ),
      ),
    );
    return assets;
  }
}
