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

  return defaultValue;
}

class StoreVipDataResult {
  StoreVipDataResult({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory StoreVipDataResult.fromJson(Map<String, dynamic> json) =>
      StoreVipDataResult(
        code: asT<int>(json['code'])!,
        data: StoreVipData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  StoreVipData data;
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

class StoreVipData {
  StoreVipData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory StoreVipData.fromJson(Map<String, dynamic> json) {
    final List<StoreVip>? data = json['data'] is List ? <StoreVip>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(StoreVip.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return StoreVipData(
      currentPage: asT<int>(json['current_page'])!,
      data: data!,
      lastPage: asT<int>(json['last_page'])!,
      total: asT<int>(json['total'])!,
    );
  }

  int currentPage;
  List<StoreVip> data;
  int lastPage;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'current_page': currentPage,
    'data': data,
    'last_page': lastPage,
    'total': total,
  };
}

class StoreVip {
  StoreVip({
    required this.id,
    required this.storeId,
    required this.name,
    required this.original,
    required this.favorable,
    required this.description,
    required this.services,
    required this.time,
    required this.meet,
    required this.status,
    required this.updatedAt,
    required this.free,
    required this.orders,
    required this.selfService,
    required this.otherService,
    required this.agreement,
    required this.limitTime,
    required this.createdAt,
  });

  factory StoreVip.fromJson(Map<String, dynamic> json) => StoreVip(
    id: asT<int>(json['id'])!,
    storeId: asT<int>(json['store_id'])!,
    name: asT<String>(json['name'])!,
    original: asT<String>(json['original'])!,
    favorable: asT<String>(json['favorable'])!,
    description: asT<String>(json['description'])!,
    services: asT<String>(json['services'])!,
    time: asT<int>(json['time'])!,
    meet: asT<int>(json['meet'])!,
    status: asT<int>(json['status'])!,
    updatedAt: asT<String>(json['updated_at'])!,
    free: asT<int>(json['free'])!,
    orders: asT<int>(json['orders'])!,
    selfService: asT<int>(json['self_service'])!,
    otherService: asT<int>(json['other_service'])!,
    agreement: asT<String>(json['agreement'])!,
    limitTime: asT<int>(json['limit_time'])!,
    createdAt: asT<String>(json['created_at'])!,
  );

  int id;
  int storeId;
  String name;
  String original;
  String favorable;
  String description;
  String services;
  int time;
  int meet;
  int status;
  String updatedAt;
  int free;
  int orders;
  int selfService;
  int otherService;
  String agreement;
  int limitTime;
  String createdAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'store_id': storeId,
    'name': name,
    'original': original,
    'favorable': favorable,
    'description': description,
    'services': services,
    'time': time,
    'meet': meet,
    'status': status,
    'updated_at': updatedAt,
    'free': free,
    'orders': orders,
    'self_service': selfService,
    'other_service': otherService,
    'agreement': agreement,
    'limit_time': limitTime,
    'created_at': createdAt,
  };
}
