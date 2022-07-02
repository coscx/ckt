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

class Loan {
  Loan({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : JsonData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  JsonData? data;
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

class JsonData {
  JsonData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory JsonData.fromJson(Map<String, dynamic> json) {
    final List<Data>? data = json['data'] is List ? <Data>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(Data.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return JsonData(
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
  List<Data>? data;
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

class Data {
  Data({
    required this.loanId,
    required this.csName,
    required this.csPhone,
    required this.cnId,
    required this.loanAmount,
    required this.loanCycle,
    required this.payType,
    required this.status,
    required this.houseArea,
    required this.decoration,
    required this.csAge,
    required this.userId,
    required this.deptId,
    required this.ancestors,
    required this.province,
    required this.city,
    required this.district,
    required this.submitTime,
    required this.incomingTime,
    required this.createTime,
    required this.houseAddress,
    required this.houseLocation,
    required this.bankBranch,
    required this.accountManager,
    required this.remark,
    required this.updateBy,
    required this.updateTime,
    required this.origin,
    required this.superId,
    required this.directorId,
    required this.superCreateTime,
    required this.directorCreateTime,
    required this.customerCreateTime,
    required this.loanRate,
    required this.abandonTime,
    required this.totalTime,
    required this.division,
    required this.bindUserId,
    required this.bindDirectorId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    loanId: json.containsKey('loan_id') ? asT<int>(json['loan_id'])! : 0,
    csName:
    json.containsKey('cs_name') ? asT<String>(json['cs_name'])! : '',
    csPhone:
    json.containsKey('cs_phone') ? asT<String>(json['cs_phone'])! : '',
    cnId: json.containsKey('cn_id') ? asT<int>(json['cn_id'])! : 0,
    loanAmount: json.containsKey('loan_amount')
        ? asT<int>(json['loan_amount'])!
        : 0,
    loanCycle:
    json.containsKey('loan_cycle') ? asT<int>(json['loan_cycle'])! : 0,
    payType: json.containsKey('pay_type') ? asT<int>(json['pay_type'])! : 0,
    status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
    houseArea:
    json.containsKey('house_area') ? asT<int>(json['house_area'])! : 0,
    decoration:
    json.containsKey('decoration') ? asT<int>(json['decoration'])! : 0,
    csAge: json.containsKey('cs_age') ? asT<int>(json['cs_age'])! : 0,
    userId: json.containsKey('user_id') ? asT<int>(json['user_id'])! : 0,
    deptId: json.containsKey('dept_id') ? asT<int>(json['dept_id'])! : 0,
    ancestors: json.containsKey('ancestors')
        ? asT<String>(json['ancestors'])!
        : '',
    province:
    json.containsKey('province') ? asT<String>(json['province'])! : '',
    city: json.containsKey('city') ? asT<String>(json['city'])! : '',
    district:
    json.containsKey('district') ? asT<String>(json['district'])! : '',
    submitTime: json.containsKey('submit_time')
        ? asT<String>(json['submit_time'])!
        : '',
    incomingTime: json.containsKey('incoming_time')
        ? asT<String>(json['incoming_time'])!
        : '',
    createTime: json.containsKey('create_time')
        ? asT<String>(json['create_time'])!
        : '',
    houseAddress: json.containsKey('house_address')
        ? asT<String>(json['house_address'])!
        : '',
    houseLocation: json.containsKey('house_location')
        ? asT<String>(json['house_location'])!
        : '',
    bankBranch: json.containsKey('bank_branch')
        ? asT<String>(json['bank_branch'])!
        : '',
    accountManager: json.containsKey('account_manager')
        ? asT<String>(json['account_manager'])!
        : '',
    remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
    updateBy: json.containsKey('update_by')
        ? asT<String>(json['update_by'])!
        : '',
    updateTime: json.containsKey('update_time')
        ? asT<String>(json['update_time'])!
        : '',
    origin: json.containsKey('origin') ? asT<int>(json['origin'])! : 0,
    superId: json.containsKey('super_id') ? asT<int>(json['super_id'])! : 0,
    directorId: json.containsKey('director_id')
        ? asT<int>(json['director_id'])!
        : 0,
    superCreateTime: json.containsKey('super_create_time')
        ? asT<String>(json['super_create_time'])!
        : '',
    directorCreateTime: json.containsKey('director_create_time')
        ? asT<String>(json['director_create_time'])!
        : '',
    customerCreateTime: json.containsKey('customer_create_time')
        ? asT<String>(json['customer_create_time'])!
        : '',
    loanRate:
    json.containsKey('loan_rate') ? asT<int>(json['loan_rate'])! : 0,
    abandonTime: json.containsKey('abandon_time')
        ? asT<String>(json['abandon_time'])!
        : '',
    totalTime: json.containsKey('total_time')
        ? asT<String>(json['total_time'])!
        : '',
    division:
    json.containsKey('division') ? asT<int>(json['division'])! : 0,
    bindUserId: json.containsKey('bind_user_id')
        ? asT<int>(json['bind_user_id'])!
        : 0,
    bindDirectorId: json.containsKey('bind_director_id')
        ? asT<int>(json['bind_director_id'])!
        : 0,
  );

  int loanId;
  String csName;
  String csPhone;
  int cnId;
  int loanAmount;
  int loanCycle;
  int payType;
  int status;
  int houseArea;
  int decoration;
  int csAge;
  int userId;
  int deptId;
  String ancestors;
  String province;
  String city;
  String district;
  String submitTime;
  String incomingTime;
  String createTime;
  String houseAddress;
  String houseLocation;
  String bankBranch;
  String accountManager;
  String remark;
  String updateBy;
  String updateTime;
  int origin;
  int superId;
  int directorId;
  String superCreateTime;
  String directorCreateTime;
  String customerCreateTime;
  int loanRate;
  String abandonTime;
  String totalTime;
  int division;
  int bindUserId;
  int bindDirectorId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'loan_id': loanId,
    'cs_name': csName,
    'cs_phone': csPhone,
    'cn_id': cnId,
    'loan_amount': loanAmount,
    'loan_cycle': loanCycle,
    'pay_type': payType,
    'status': status,
    'house_area': houseArea,
    'decoration': decoration,
    'cs_age': csAge,
    'user_id': userId,
    'dept_id': deptId,
    'ancestors': ancestors,
    'province': province,
    'city': city,
    'district': district,
    'submit_time': submitTime,
    'incoming_time': incomingTime,
    'create_time': createTime,
    'house_address': houseAddress,
    'house_location': houseLocation,
    'bank_branch': bankBranch,
    'account_manager': accountManager,
    'remark': remark,
    'update_by': updateBy,
    'update_time': updateTime,
    'origin': origin,
    'super_id': superId,
    'director_id': directorId,
    'super_create_time': superCreateTime,
    'director_create_time': directorCreateTime,
    'customer_create_time': customerCreateTime,
    'loan_rate': loanRate,
    'abandon_time': abandonTime,
    'total_time': totalTime,
    'division': division,
    'bind_user_id': bindUserId,
    'bind_director_id': bindDirectorId,
  };
}
