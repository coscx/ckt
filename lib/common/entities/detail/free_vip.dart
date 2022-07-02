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

class FreeVipDataResult {
  FreeVipDataResult({
    required this.status,
    required this.code,
    required this.data,
    this.message
  });

  factory FreeVipDataResult.fromJson(Map<String, dynamic> json) =>
      FreeVipDataResult(
        status: json.containsKey('status')? asT<String>(json['status'])!:"",
        code: asT<int>(json['code'])!,
        data: FreeVipData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        message: json.containsKey('message')? asT<String>(json['message'])! :"",
      );

  String status;
  int code;
  FreeVipData data;
  String? message;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'code': code,
    'data': data,
    'message':message
  };
}

class FreeVipData {
  FreeVipData({
    required this.id,
  });

  factory FreeVipData.fromJson(Map<String, dynamic> json) => FreeVipData(
    id: Id.fromJson(asT<Map<String, dynamic>>(json['id'])!),
  );

  Id id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
  };
}

class Id {
  Id({
    required this.favorable,
    required this.storeId,
    required this.time,
    required this.meet,
    required this.description,
    required this.name,
    required this.services,
    required this.original,
    required this.free,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    favorable: json.containsKey('status')? asT<String>(json['favorable'])!:"",
    storeId: json.containsKey('status')? asT<String>(json['store_id'])!:"",
    time: json.containsKey('status')? asT<String>(json['time'])!:"",
    meet: json.containsKey('status')? asT<String>(json['meet'])!:"",
    description: json.containsKey('status')? asT<String>(json['description'])!:"",
    name: json.containsKey('status')? asT<String>(json['name'])!:"",
    services: json.containsKey('status')? asT<String>(json['services'])!:"",
    original: json.containsKey('status')? asT<String>(json['original'])!:"",
    free: json.containsKey('status')? asT<int>(json['free'])!:0,
    updatedAt: json.containsKey('status')? asT<String>(json['updated_at'])!:"",
    createdAt: json.containsKey('status')? asT<String>(json['created_at'])!:"",
    id: json.containsKey('status')? asT<int>(json['id'])!:0,
  );

  String favorable;
  String storeId;
  String time;
  String meet;
  String description;
  String name;
  String services;
  String original;
  int free;
  String updatedAt;
  String createdAt;
  int id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'favorable': favorable,
    'store_id': storeId,
    'time': time,
    'meet': meet,
    'description': description,
    'name': name,
    'services': services,
    'original': original,
    'free': free,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
  };
}
