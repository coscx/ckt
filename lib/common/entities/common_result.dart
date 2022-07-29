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

class CommonResult {
  CommonResult({
    required this.status,
    required this.code,
    required this.data,
    this.message,
    this.msg
  });

  factory CommonResult.fromJson(Map<String, dynamic> json) => CommonResult(
    status: json.containsKey('status')? asT<String>(json['status'])!:"",
    code: asT<int>(json['code'])!,
    data: json.containsKey('data')? asT<String>(json['data']):"",
    message: json.containsKey('message')? asT<String>(json['message'])! :"",
    msg: json.containsKey('msg')? asT<String>(json['msg'])! :"",
  );

  String status;
  int code;
  String? data;
  String? message;
  String? msg;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'code': code,
    'data': data,
    'msg': msg,
  };
}
