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
    return defaultValue;
  }

  return defaultValue;
}

class AppVersionEntity {
  AppVersionEntity({
    required this.status,
    required this.code,
    required this.data,
  });

  factory AppVersionEntity.fromJson(Map<String, dynamic> json) => AppVersionEntity(
    status: json.containsKey('status')? asT<String>(json['status'])!:"",
    code: asT<int>(json['code'])!,
    data: Data.fromJson(asT<Map<String, dynamic>>(json['data'])!),
  );

  String status;
  int code;
  Data data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'code': code,
    'data': data,
  };

  AppVersionEntity copy() {
    return AppVersionEntity(
      status: status,
      code: code,
      data: data.copy(),
    );
  }
}

class Data {
  Data({
    required this.isforce,
    required this.hasupdate,
    required this.isignorable,
    required this.versioncode,
    required this.versionname,
    required this.updatelog,
    required this.apkurl,
    required this.apksize,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isforce: asT<int>(json['isForce'])!,
    hasupdate: asT<bool>(json['hasUpdate'])!,
    isignorable: asT<bool>(json['isIgnorable'])!,
    versioncode: asT<String>(json['versionCode'])!,
    versionname: asT<String>(json['versionName'])!,
    updatelog: asT<String>(json['updateLog'])!,
    apkurl: asT<String>(json['apkUrl'])!,
    apksize: asT<String>(json['apkSize'])!,
  );

  int isforce;
  bool hasupdate;
  bool isignorable;
  String versioncode;
  String versionname;
  String updatelog;
  String apkurl;
  String apksize;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'isForce': isforce,
    'hasUpdate': hasupdate,
    'isIgnorable': isignorable,
    'versionCode': versioncode,
    'versionName': versionname,
    'updateLog': updatelog,
    'apkUrl': apkurl,
    'apkSize': apksize,
  };

  Data copy() {
    return Data(
      isforce: isforce,
      hasupdate: hasupdate,
      isignorable: isignorable,
      versioncode: versioncode,
      versionname: versionname,
      updatelog: updatelog,
      apkurl: apkurl,
      apksize: apksize,
    );
  }
}
