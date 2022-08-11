import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
  }
  if ('' is T) {
    return '' as T;
  } else if (0 is T) {
    return 0 as T;
  } else if (0.0 is T) {
    return 0.0 as T;
  } else if (false is T) {
    return false as T;
  }
  return defaultValue;
}

class Version {
  Version({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : VersionData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  VersionData? data;
  String msg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'data': data,
    'msg': msg,
  };
}

class VersionData {
  VersionData({
    required this.id,
    required this.isShow,
    required this.androidVersion,
    required this.androidVersionCode,
    required this.remark,
    required this.androidIsForce,
    required this.androidIsUpdate,
    required this.iosVersion,
    required this.iosIsForce,
    required this.iosIsUpdate,
    required this.androidUrl,
    required this.iosUrl,
    required this.kefuShow,
    required this.size,
  });

  factory VersionData.fromJson(Map<String, dynamic> json) => VersionData(
    id: json.containsKey('id') ? asT<int>(json['id'])! : 0,
    isShow: json.containsKey('is_show') ? asT<int>(json['is_show'])! : 0,
    androidVersion: json.containsKey('android_version')
        ? asT<String>(json['android_version'])!
        : '',
    androidVersionCode: json.containsKey('android_version_code')
        ? asT<String>(json['android_version_code'])!
        : '',
    remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
    androidIsForce: json.containsKey('android_is_force')
        ? asT<int>(json['android_is_force'])!
        : 0,
    androidIsUpdate: json.containsKey('android_is_update')
        ? asT<int>(json['android_is_update'])!
        : 0,
    iosVersion: json.containsKey('ios_version')
        ? asT<String>(json['ios_version'])!
        : '',
    iosIsForce: json.containsKey('ios_is_force')
        ? asT<int>(json['ios_is_force'])!
        : 0,
    iosIsUpdate: json.containsKey('ios_is_update')
        ? asT<int>(json['ios_is_update'])!
        : 0,
    androidUrl: json.containsKey('android_url')
        ? asT<String>(json['android_url'])!
        : '',
    iosUrl:
    json.containsKey('ios_url') ? asT<String>(json['ios_url'])! : '',
    kefuShow:
    json.containsKey('kefu_show') ? asT<int>(json['kefu_show'])! : 0,
    size: json.containsKey('size') ? asT<int>(json['size'])! : 0,
  );

  int id;
  int isShow;
  String androidVersion;
  String androidVersionCode;
  String remark;
  int androidIsForce;
  int androidIsUpdate;
  String iosVersion;
  int iosIsForce;
  int iosIsUpdate;
  String androidUrl;
  String iosUrl;
  int kefuShow;
  int size;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'is_show': isShow,
    'android_version': androidVersion,
    'android_version_code': androidVersionCode,
    'remark': remark,
    'android_is_force': androidIsForce,
    'android_is_update': androidIsUpdate,
    'ios_version': iosVersion,
    'ios_is_force': iosIsForce,
    'ios_is_update': iosIsUpdate,
    'android_url': androidUrl,
    'ios_url': iosUrl,
    'kefu_show': kefuShow,
    'size': size,
  };
}
