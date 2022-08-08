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

class SaleManGrid {
  SaleManGrid({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory SaleManGrid.fromJson(Map<String, dynamic> json) => SaleManGrid(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : SaleManGridData.fromJson(
        asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  SaleManGridData? data;
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

class SaleManGridData {
  SaleManGridData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory SaleManGridData.fromJson(Map<String, dynamic> json) =>
      SaleManGridData(
        currentPage: json.containsKey('current_page')
            ? asT<int>(json['current_page'])!
            : 0,
        data: json.containsKey('data')
            ? json['data'] == null
            ? null
            : SaleManGridDataData.fromJson(
            asT<Map<String, dynamic>>(json['data'])!)
            : null,
        lastPage:
        json.containsKey('last_page') ? asT<int>(json['last_page'])! : 0,
        total: json.containsKey('total') ? asT<int>(json['total'])! : 0,
      );

  int currentPage;
  SaleManGridDataData? data;
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

class SaleManGridDataData {
  SaleManGridDataData({
    required this.pendingsupplement,
    required this.pendingsubmission,
    required this.pendingcontact,
  });

  factory SaleManGridDataData.fromJson(Map<String, dynamic> json) =>
      SaleManGridDataData(
        pendingsupplement: json.containsKey('pendingSupplement')
            ? asT<int>(json['pendingSupplement'])!
            : 0,
        pendingsubmission: json.containsKey('pendingSubmission')
            ? asT<int>(json['pendingSubmission'])!
            : 0,
        pendingcontact: json.containsKey('pendingContact')
            ? asT<int>(json['pendingContact'])!
            : 0,
      );

  int pendingsupplement;
  int pendingsubmission;
  int pendingcontact;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pendingSupplement': pendingsupplement,
    'pendingSubmission': pendingsubmission,
    'pendingContact': pendingcontact,
  };
}
