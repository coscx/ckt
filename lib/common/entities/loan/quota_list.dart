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

class QuotaList {
  QuotaList({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory QuotaList.fromJson(Map<String, dynamic> json) => QuotaList(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : QuotaListData.fromJson(
        asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  QuotaListData? data;
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

class QuotaListData {
  QuotaListData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory QuotaListData.fromJson(Map<String, dynamic> json) {
    final List<QuotaListDataData>? data =
    json['data'] is List ? <QuotaListDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(
                QuotaListDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return QuotaListData(
      currentPage: json.containsKey('current_page')
          ? asT<int>(json['current_page'])!
          : 0,
      data: data,
      lastPage:
      json.containsKey('last_page') ? asT<int>(json['last_page'])! : 0,
      total: json.containsKey('total') ? asT<int>(json['total'])! : 0,
    );
  }

  int currentPage;
  List<QuotaListDataData>? data;
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

class QuotaListDataData {
  QuotaListDataData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.result,
    required this.userId,
    required this.addTime,
  });

  factory QuotaListDataData.fromJson(Map<String, dynamic> json) =>
      QuotaListDataData(
        id: json.containsKey('id') ? asT<int>(json['id'])! : 0,
        name: json.containsKey('name') ? asT<String>(json['name'])! : '',
        mobile: json.containsKey('mobile') ? asT<String>(json['mobile'])! : '',
        result: json.containsKey('result') ? asT<String>(json['result'])! : '',
        userId: json.containsKey('user_id') ? asT<int>(json['user_id'])! : 0,
        addTime:
        json.containsKey('add_time') ? asT<String>(json['add_time'])! : '',
      );

  int id;
  String name;
  String mobile;
  String result;
  int userId;
  String addTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'mobile': mobile,
    'result': result,
    'user_id': userId,
    'add_time': addTime,
  };
}
