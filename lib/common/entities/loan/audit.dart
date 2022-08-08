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

class Audit {
  Audit({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : AuditData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  AuditData? data;
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

class AuditData {
  AuditData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory AuditData.fromJson(Map<String, dynamic> json) {
    final List<AuditDataData>? data =
    json['data'] is List ? <AuditDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(AuditDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AuditData(
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
  List<AuditDataData>? data;
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

class AuditDataData {
  AuditDataData({
    required this.csphone,
    required this.channel,
    this.divisionname,
    this.directorcreatetime,
    required this.binduserid,
    required this.loancycle,
    required this.division,
    this.paytype,
    this.province,
    required this.incomingtime,
    this.cumulativeamount,
    this.superid,
    this.credit,
    this.decoration,
    this.curstaff,
    this.directorid,
    this.totaltime,
    this.deptid,
    required this.params,
    this.steps,
    this.originalcnid,
    required this.submittime,
    required this.district,
    required this.customercreatetime,
    this.identificationurl,
    this.credittime,
    required this.loanid,
    required this.status,
    required this.city,
    required this.csage,
    required this.origin,
    required this.cnid,
    this.remark,
    this.realamount,
    required this.curuserid,
    required this.accountmanager,
    required this.updateby,
    this.supercreatetime,
    required this.housearea,
    this.circulations,
    this.abandontime,
    required this.bankbranch,
    this.deedurl,
    required this.updatetime,
    this.staff,
    required this.userid,
    required this.loanamount,
    this.createby,
    required this.csname,
    required this.createtime,
    this.searchvalue,
    this.loanrate,
    required this.houseaddress,
  });

  factory AuditDataData.fromJson(Map<String, dynamic> json) => AuditDataData(
    csphone:
    json.containsKey('csPhone') ? asT<String>(json['csPhone'])! : '',
    channel: json.containsKey('channel')
        ? json['channel'] == null
        ? null
        : Channel.fromJson(asT<Map<String, dynamic>>(json['channel'])!)
        : null,
    divisionname: json.containsKey('divisionName')
        ? asT<Object?>(json['divisionName'])
        : null,
    directorcreatetime: json.containsKey('directorCreateTime')
        ? asT<Object?>(json['directorCreateTime'])
        : null,
    binduserid:
    json.containsKey('bindUserId') ? asT<int>(json['bindUserId'])! : 0,
    loancycle:
    json.containsKey('loanCycle') ? asT<int>(json['loanCycle'])! : 0,
    division:
    json.containsKey('division') ? asT<int>(json['division'])! : 0,
    paytype:
    json.containsKey('payType') ? asT<Object?>(json['payType']) : null,
    province: json.containsKey('province')
        ? asT<Object?>(json['province'])
        : null,
    incomingtime: json.containsKey('incomingTime')
        ? asT<String>(json['incomingTime'])!
        : '',
    cumulativeamount: json.containsKey('cumulativeAmount')
        ? asT<Object?>(json['cumulativeAmount'])
        : null,
    superid:
    json.containsKey('superId') ? asT<Object?>(json['superId']) : null,
    credit:
    json.containsKey('credit') ? asT<Object?>(json['credit']) : null,
    decoration: json.containsKey('decoration')
        ? asT<Object?>(json['decoration'])
        : null,
    curstaff: json.containsKey('curStaff')
        ? asT<Object?>(json['curStaff'])
        : null,
    directorid: json.containsKey('directorId')
        ? asT<Object?>(json['directorId'])
        : null,
    totaltime: json.containsKey('totalTime')
        ? asT<Object?>(json['totalTime'])
        : null,
    deptid:
    json.containsKey('deptId') ? asT<Object?>(json['deptId']) : null,
    params:
    json.containsKey('params') ? asT<Object>(json['params'])! : null,
    steps: json.containsKey('steps') ? asT<Object?>(json['steps']) : null,
    originalcnid: json.containsKey('originalCnId')
        ? asT<Object?>(json['originalCnId'])
        : null,
    submittime: json.containsKey('submitTime')
        ? asT<String>(json['submitTime'])!
        : '',
    district:
    json.containsKey('district') ? asT<String>(json['district'])! : '',
    customercreatetime: json.containsKey('customerCreateTime')
        ? asT<String>(json['customerCreateTime'])!
        : '',
    identificationurl: json.containsKey('identificationUrl')
        ? asT<Object?>(json['identificationUrl'])
        : null,
    credittime: json.containsKey('creditTime')
        ? asT<Object?>(json['creditTime'])
        : null,
    loanid: json.containsKey('loanId') ? asT<int>(json['loanId'])! : 0,
    status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
    city: json.containsKey('city') ? asT<String>(json['city'])! : '',
    csage: json.containsKey('csAge') ? asT<int>(json['csAge'])! : 0,
    origin: json.containsKey('origin') ? asT<int>(json['origin'])! : 0,
    cnid: json.containsKey('cnId') ? asT<int>(json['cnId'])! : 0,
    remark:
    json.containsKey('remark') ? asT<Object?>(json['remark']) : null,
    realamount: json.containsKey('realAmount')
        ? asT<Object?>(json['realAmount'])
        : null,
    curuserid:
    json.containsKey('curUserId') ? asT<int>(json['curUserId'])! : 0,
    accountmanager: json.containsKey('accountManager')
        ? asT<String>(json['accountManager'])!
        : '',
    updateby:
    json.containsKey('updateBy') ? asT<String>(json['updateBy'])! : '',
    supercreatetime: json.containsKey('superCreateTime')
        ? asT<Object?>(json['superCreateTime'])
        : null,
    housearea:
    json.containsKey('houseArea') ? asT<double>(json['houseArea'])! : 0,
    circulations: json.containsKey('circulations')
        ? asT<Object?>(json['circulations'])
        : null,
    abandontime: json.containsKey('abandonTime')
        ? asT<Object?>(json['abandonTime'])
        : null,
    bankbranch: json.containsKey('bankBranch')
        ? asT<String>(json['bankBranch'])!
        : '',
    deedurl:
    json.containsKey('deedUrl') ? asT<Object?>(json['deedUrl']) : null,
    updatetime: json.containsKey('updateTime')
        ? asT<String>(json['updateTime'])!
        : '',
    staff: json.containsKey('staff') ? asT<Object?>(json['staff']) : null,
    userid: json.containsKey('userId') ? asT<int>(json['userId'])! : 0,
    loanamount:
    json.containsKey('loanAmount') ? asT<int>(json['loanAmount'])! : 0,
    createby: json.containsKey('createBy')
        ? asT<Object?>(json['createBy'])
        : null,
    csname: json.containsKey('csName') ? asT<String>(json['csName'])! : '',
    createtime: json.containsKey('createTime')
        ? asT<String>(json['createTime'])!
        : '',
    searchvalue: json.containsKey('searchValue')
        ? asT<Object?>(json['searchValue'])
        : null,
    loanrate: json.containsKey('loanRate')
        ? asT<Object?>(json['loanRate'])
        : null,
    houseaddress: json.containsKey('houseAddress')
        ? asT<String>(json['houseAddress'])!
        : '',
  );

  String csphone;
  Channel? channel;
  Object? divisionname;
  Object? directorcreatetime;
  int binduserid;
  int loancycle;
  int division;
  Object? paytype;
  Object? province;
  String incomingtime;
  Object? cumulativeamount;
  Object? superid;
  Object? credit;
  Object? decoration;
  Object? curstaff;
  Object? directorid;
  Object? totaltime;
  Object? deptid;
  Object? params;
  Object? steps;
  Object? originalcnid;
  String submittime;
  String district;
  String customercreatetime;
  Object? identificationurl;
  Object? credittime;
  int loanid;
  int status;
  String city;
  int csage;
  int origin;
  int cnid;
  Object? remark;
  Object? realamount;
  int curuserid;
  String accountmanager;
  String updateby;
  Object? supercreatetime;
  double housearea;
  Object? circulations;
  Object? abandontime;
  String bankbranch;
  Object? deedurl;
  String updatetime;
  Object? staff;
  int userid;
  int loanamount;
  Object? createby;
  String csname;
  String createtime;
  Object? searchvalue;
  Object? loanrate;
  String houseaddress;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'csPhone': csphone,
    'channel': channel,
    'divisionName': divisionname,
    'directorCreateTime': directorcreatetime,
    'bindUserId': binduserid,
    'loanCycle': loancycle,
    'division': division,
    'payType': paytype,
    'province': province,
    'incomingTime': incomingtime,
    'cumulativeAmount': cumulativeamount,
    'superId': superid,
    'credit': credit,
    'decoration': decoration,
    'curStaff': curstaff,
    'directorId': directorid,
    'totalTime': totaltime,
    'deptId': deptid,
    'params': params,
    'steps': steps,
    'originalCnId': originalcnid,
    'submitTime': submittime,
    'district': district,
    'customerCreateTime': customercreatetime,
    'identificationUrl': identificationurl,
    'creditTime': credittime,
    'loanId': loanid,
    'status': status,
    'city': city,
    'csAge': csage,
    'origin': origin,
    'cnId': cnid,
    'remark': remark,
    'realAmount': realamount,
    'curUserId': curuserid,
    'accountManager': accountmanager,
    'updateBy': updateby,
    'superCreateTime': supercreatetime,
    'houseArea': housearea,
    'circulations': circulations,
    'abandonTime': abandontime,
    'bankBranch': bankbranch,
    'deedUrl': deedurl,
    'updateTime': updatetime,
    'staff': staff,
    'userId': userid,
    'loanAmount': loanamount,
    'createBy': createby,
    'csName': csname,
    'createTime': createtime,
    'searchValue': searchvalue,
    'loanRate': loanrate,
    'houseAddress': houseaddress,
  };
}

class Channel {
  Channel({
    required this.cntype,
    required this.code,
    required this.ascription,
    required this.cncode,
    required this.origin,
    required this.cnid,
    required this.deptid,
    this.updatetime,
    this.remark,
    required this.params,
    required this.userid,
    required this.createby,
    required this.cnname,
    required this.createtime,
    required this.updateby,
    this.ancestors,
    this.searchvalue,
    this.status,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    cntype: json.containsKey('cnType') ? asT<int>(json['cnType'])! : 0,
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    ascription:
    json.containsKey('ascription') ? asT<int>(json['ascription'])! : 0,
    cncode: json.containsKey('cnCode') ? asT<String>(json['cnCode'])! : '',
    origin: json.containsKey('origin') ? asT<int>(json['origin'])! : 0,
    cnid: json.containsKey('cnId') ? asT<int>(json['cnId'])! : 0,
    deptid: json.containsKey('deptId') ? asT<int>(json['deptId'])! : 0,
    updatetime: json.containsKey('updateTime')
        ? asT<Object?>(json['updateTime'])
        : null,
    remark:
    json.containsKey('remark') ? asT<Object?>(json['remark']) : null,
    params:
    json.containsKey('params') ? asT<Object>(json['params'])! : null,
    userid: json.containsKey('userId') ? asT<int>(json['userId'])! : 0,
    createby:
    json.containsKey('createBy') ? asT<String>(json['createBy'])! : '',
    cnname: json.containsKey('cnName') ? asT<String>(json['cnName'])! : '',
    createtime: json.containsKey('createTime')
        ? asT<String>(json['createTime'])!
        : '',
    updateby:
    json.containsKey('updateBy') ? asT<String>(json['updateBy'])! : '',
    ancestors: json.containsKey('ancestors')
        ? asT<Object?>(json['ancestors'])
        : null,
    searchvalue: json.containsKey('searchValue')
        ? asT<Object?>(json['searchValue'])
        : null,
    status:
    json.containsKey('status') ? asT<Object?>(json['status']) : null,
  );

  int cntype;
  int code;
  int ascription;
  String cncode;
  int origin;
  int cnid;
  int deptid;
  Object? updatetime;
  Object? remark;
  Object? params;
  int userid;
  String createby;
  String cnname;
  String createtime;
  String updateby;
  Object? ancestors;
  Object? searchvalue;
  Object? status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'cnType': cntype,
    'code': code,
    'ascription': ascription,
    'cnCode': cncode,
    'origin': origin,
    'cnId': cnid,
    'deptId': deptid,
    'updateTime': updatetime,
    'remark': remark,
    'params': params,
    'userId': userid,
    'createBy': createby,
    'cnName': cnname,
    'createTime': createtime,
    'updateBy': updateby,
    'ancestors': ancestors,
    'searchValue': searchvalue,
    'status': status,
  };
}
