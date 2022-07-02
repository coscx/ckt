import 'package:flutter/material.dart';
import 'functions.dart';
import 'image_util.dart';
import '../../../common/widgets/chat/more_widgets.dart';

class PopupWindowUtil {
  /*
  * 选择相机相册
  */
  static Future showPhotoChosen(BuildContext context, {OnCallBack? onCallBack}) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading:  const Icon(Icons.photo_camera),
                title:  const Text("拍照"),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.getCameraImage(context).then((image) {
                    if (onCallBack != null) {
                      onCallBack(image);
                    }
                  });
                },
              ),
              MoreWidgets.buildDivider(height: 0),
               ListTile(
                leading:  const Icon(Icons.photo_library),
                title:  const Text("相册"),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.getGalleryImage(context).then((image) {
                    if (onCallBack != null) {
                      onCallBack(image);
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  /*
  * 选择拍照片、拍视频
  */
  static Future showCameraChosen(BuildContext context, {OnCallBackWithType? onCallBack}) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("拍照片"),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.getCameraImage(context).then((image) {
                    if (onCallBack != null) {
                      onCallBack(1, image);
                    }
                  });
                },
              ),
              MoreWidgets.buildDivider(height: 0),
               ListTile(
                leading:  const Icon(Icons.photo_library),
                title:  const Text("拍视频"),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.getCameraVideo(context).then((image) {
                    if (onCallBack != null) {
                      onCallBack(2, image);
                    }
                  });
                },
              ),
            ],
          );
        });
  }
}
