import 'package:permission_handler/permission_handler.dart';
void checkPermission() async {
  Permission permission = Permission.speech;
  permission =  Permission.camera;
  permission =  Permission.storage;
  PermissionStatus status = await permission.status;
  print('检测权限$status');
  if (status.isGranted) {
    //权限通过
  } else if (status.isDenied) {
    //权限拒绝， 需要区分IOS和Android，二者不一样
    requestPermission(permission);
  } else if (status.isPermanentlyDenied) {
    //权限永久拒绝，且不在提示，需要进入设置界面
    openAppSettings();
  } else if (status.isRestricted) {
    //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
    openAppSettings();
  } else {
    //第一次申请
    requestPermission(permission);
  }
}
//申请权限
void requestPermission(Permission permission) async {
  PermissionStatus status = await permission.request();
  print('权限状态$status');
  if (!status.isGranted) {
    openAppSettings();
  }
}
void requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.location,
    Permission.speech,
  ].request();
  print('位置权限：${statuses[Permission.location]}');
  print('存储权限：${statuses[Permission.storage]}');
  print('相机权限：${statuses[Permission.camera]}');
  print('话筒权限：${statuses[Permission.speech]}');


  bool isShown = await Permission.contacts.shouldShowRequestRationale;
}