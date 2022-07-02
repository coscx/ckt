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

class LoanDetail {
  LoanDetail({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory LoanDetail.fromJson(Map<String, dynamic> json) => LoanDetail(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : Data.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  Data? data;
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

class Data {
  Data({
    required this.data,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<LoanData>? data = json['data'] is List ? <LoanData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(LoanData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      data: data,
      total: json.containsKey('total') ? asT<int>(json['total'])! : 0,
    );
  }

  List<LoanData>? data;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'total': total,
  };
}

class LoanData {
  LoanData({
    required this.circulationId,
    required this.loanId,
    required this.status,
    required this.createTime,
    required this.createBy,
    required this.timeConsuming,
    required this.remark,
    required this.step,
    required this.owner,
    required this.updateBy,
    required this.pic,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) {
    final List<Pic>? pic = json['pic'] is List ? <Pic>[] : null;
    if (pic != null) {
      for (final dynamic item in json['pic']!) {
        if (item != null) {
          tryCatch(() {
            pic.add(Pic.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return LoanData(
      circulationId: json.containsKey('circulation_id')
          ? asT<int>(json['circulation_id'])!
          : 0,
      loanId: json.containsKey('loan_id') ? asT<int>(json['loan_id'])! : 0,
      status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
      createTime: json.containsKey('create_time')
          ? asT<String>(json['create_time'])!
          : '',
      createBy:
      json.containsKey('create_by') ? asT<String>(json['create_by'])! : '',
      timeConsuming: json.containsKey('time_consuming')
          ? asT<String>(json['time_consuming'])!
          : '',
      remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
      step: json.containsKey('step') ? asT<int>(json['step'])! : 0,
      owner: json.containsKey('owner') ? asT<int>(json['owner'])! : 0,
      updateBy:
      json.containsKey('update_by') ? asT<String>(json['update_by'])! : '',
      pic: pic,
    );
  }

  int circulationId;
  int loanId;
  int status;
  String createTime;
  String createBy;
  String timeConsuming;
  String remark;
  int step;
  int owner;
  String updateBy;
  List<Pic>? pic;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'circulation_id': circulationId,
    'loan_id': loanId,
    'status': status,
    'create_time': createTime,
    'create_by': createBy,
    'time_consuming': timeConsuming,
    'remark': remark,
    'step': step,
    'owner': owner,
    'update_by': updateBy,
    'pic': pic,
  };
}

class Pic {
  Pic({
    required this.circulationId,
    required this.picType,
    required this.picUrl,
  });

  factory Pic.fromJson(Map<String, dynamic> json) => Pic(
    circulationId: json.containsKey('circulation_id')
        ? asT<int>(json['circulation_id'])!
        : 0,
    picType: json.containsKey('pic_type') ? asT<int>(json['pic_type'])! : 0,
    picUrl:
    json.containsKey('pic_url') ? asT<String>(json['pic_url'])! : '',
  );

  int circulationId;
  int picType;
  String picUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'circulation_id': circulationId,
    'pic_type': picType,
    'pic_url': picUrl,
  };
}
