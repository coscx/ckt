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

class Step {
  Step({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : StepData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  StepData? data;
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

class StepData {
  StepData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory StepData.fromJson(Map<String, dynamic> json) {
    final List<StepDataData>? data =
    json['data'] is List ? <StepDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(StepDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return StepData(
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
  List<StepDataData>? data;
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

class StepDataData {
  StepDataData({
    required this.num,
    required this.label,
    required this.status,
  });

  factory StepDataData.fromJson(Map<String, dynamic> json) => StepDataData(
    num: json.containsKey('num') ? asT<int>(json['num'])! : 0,
    label: json.containsKey('label') ? asT<String>(json['label'])! : '',
    status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
  );

  int num;
  String label;
  int status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'num': num,
    'label': label,
    'status': status,
  };
}
