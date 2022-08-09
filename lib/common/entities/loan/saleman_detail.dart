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

class SaleManDetail {
  SaleManDetail({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory SaleManDetail.fromJson(Map<String, dynamic> json) => SaleManDetail(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : SaleManDetailData.fromJson(
        asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  SaleManDetailData? data;
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

class SaleManDetailData {
  SaleManDetailData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory SaleManDetailData.fromJson(Map<String, dynamic> json) =>
      SaleManDetailData(
        currentPage: json.containsKey('current_page')
            ? asT<int>(json['current_page'])!
            : 0,
        data: json.containsKey('data')
            ? json['data'] == null
            ? null
            : SaleManDetailDataData.fromJson(
            asT<Map<String, dynamic>>(json['data'])!)
            : null,
        lastPage:
        json.containsKey('last_page') ? asT<int>(json['last_page'])! : 0,
        total: json.containsKey('total') ? asT<int>(json['total'])! : 0,
      );

  int currentPage;
  SaleManDetailDataData? data;
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

class SaleManDetailDataData {

  SaleManDetailDataData({
    required this.csphone,
    required this.channel,
    this.divisionname,
    required this.directorcreatetime,
    required this.binduserid,
    this.loancycle,
    required this.division,
    this.paytype,
    this.province,
    required this.incomingtime,
    required this.cumulativeamount,
    this.superid,
    this.credit,
    this.decoration,
    this.curstaff,
    required this.directorid,
    required this.totaltime,
    this.deptid,
    this.params,
    this.steps,
    this.originalcnid,
    required this.submittime,
    this.district,
    required this.customercreatetime,
    this.identificationurl,
    required this.credittime,
    required this.loanid,
    required this.status,
    this.city,
    this.csage,
    required this.origin,
    required this.cnid,
    required this.remark,
    required this.realamount,
    required this.curuserid,
    required this.accountmanager,
    required this.updateby,
    this.supercreatetime,
    required this.housearea,
    required this.circulations,
    this.abandontime,
    required this.bankbranch,
    this.deedurl,
    required this.updatetime,
    required this.staff,
    required this.userid,
    required this.loanamount,
    this.createby,
    required this.csname,
    required this.createtime,
    this.searchvalue,
    this.loanrate,
    required this.houseaddress,
    required this.bankid,
  });

  factory SaleManDetailDataData.fromJson(Map<String, dynamic> json) {
    final List<Circulations>? circulations =
    json['circulations'] is List ? <Circulations>[] : null;
    if (circulations != null) {
      for (final dynamic item in json['circulations']!) {
        if (item != null) {
          tryCatch(() {
            circulations
                .add(Circulations.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return SaleManDetailDataData(
      csphone: json.containsKey('csPhone') ? asT<String>(json['csPhone'])! : '',
      channel: json.containsKey('channel')
          ? json['channel'] == null
          ? null
          : Channel.fromJson(asT<Map<String, dynamic>>(json['channel'])!)
          : null,
      divisionname: json.containsKey('divisionName')
          ? asT<Object?>(json['divisionName'])
          : null,
      directorcreatetime: json.containsKey('directorCreateTime')
          ? asT<String>(json['directorCreateTime'])!
          : '',
      binduserid:
      json.containsKey('bindUserId') ? asT<int>(json['bindUserId'])! : 0,
      loancycle: json.containsKey('loanCycle')
          ? asT<Object?>(json['loanCycle'])
          : null,
      division: json.containsKey('division') ? asT<int>(json['division'])! : 0,
      paytype:
      json.containsKey('payType') ? asT<Object?>(json['payType']) : null,
      province:
      json.containsKey('province') ? asT<Object?>(json['province']) : null,
      incomingtime: json.containsKey('incomingTime')
          ? asT<String>(json['incomingTime'])!
          : '',
      cumulativeamount: json.containsKey('cumulativeAmount')
          ? asT<int>(json['cumulativeAmount'])!
          : 0,
      superid:
      json.containsKey('superId') ? asT<Object?>(json['superId']) : null,
      credit: json.containsKey('credit') ? asT<Object?>(json['credit']) : null,
      decoration: json.containsKey('decoration')
          ? asT<Object?>(json['decoration'])
          : null,
      curstaff:
      json.containsKey('curStaff') ? asT<Object?>(json['curStaff']) : null,
      directorid:
      json.containsKey('directorId') ? asT<int>(json['directorId'])! : 0,
      totaltime:
      json.containsKey('totalTime') ? asT<String>(json['totalTime'])! : '',
      deptid: json.containsKey('deptId') ? asT<Object?>(json['deptId']) : null,
      params: json.containsKey('params')
          ? asT<Map<String, dynamic>?>(json['params'])
          : null,
      steps: json.containsKey('steps') ? asT<Object?>(json['steps']) : null,
      originalcnid: json.containsKey('originalCnId')
          ? asT<Object?>(json['originalCnId'])
          : null,
      submittime: json.containsKey('submitTime')
          ? asT<String>(json['submitTime'])!
          : '',
      district:
      json.containsKey('district') ? asT<Object?>(json['district']) : null,
      customercreatetime: json.containsKey('customerCreateTime')
          ? asT<String>(json['customerCreateTime'])!
          : '',
      identificationurl: json.containsKey('identificationUrl')
          ? asT<Object?>(json['identificationUrl'])
          : null,
      credittime: json.containsKey('creditTime')
          ? asT<String>(json['creditTime'])!
          : '',
      loanid: json.containsKey('loanId') ? asT<int>(json['loanId'])! : 0,
      bankid: json.containsKey('bankId') ? asT<int>(json['bankId'])! : 0,
      status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
      city: json.containsKey('city') ? asT<Object?>(json['city']) : null,
      csage: json.containsKey('csAge') ? asT<Object?>(json['csAge']) : null,
      origin: json.containsKey('origin') ? asT<int>(json['origin'])! : 0,
      cnid: json.containsKey('cnId') ? asT<int>(json['cnId'])! : 0,
      remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
      realamount:
      json.containsKey('realAmount') ? asT<int>(json['realAmount'])! : 0,
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
      json.containsKey('houseArea') ? asT<int>(json['houseArea'])! : 0,
      circulations: circulations,
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
      staff: json.containsKey('staff') ? asT<String>(json['staff'])! : '',
      userid: json.containsKey('userId') ? asT<int>(json['userId'])! : 0,
      loanamount:
      json.containsKey('loanAmount') ? asT<int>(json['loanAmount'])! : 0,
      createby:
      json.containsKey('createBy') ? asT<Object?>(json['createBy']) : null,
      csname: json.containsKey('csName') ? asT<String>(json['csName'])! : '',
      createtime: json.containsKey('createTime')
          ? asT<String>(json['createTime'])!
          : '',
      searchvalue: json.containsKey('searchValue')
          ? asT<Object?>(json['searchValue'])
          : null,
      loanrate:
      json.containsKey('loanRate') ? asT<Object?>(json['loanRate']) : null,
      houseaddress: json.containsKey('houseAddress')
          ? asT<String>(json['houseAddress'])!
          : '',
    );
  }

  String csphone;
  Channel? channel;
  Object? divisionname;
  String directorcreatetime;
  int binduserid;
  Object? loancycle;
  int division;
  Object? paytype;
  Object? province;
  String incomingtime;
  int cumulativeamount;
  Object? superid;
  Object? credit;
  Object? decoration;
  Object? curstaff;
  int directorid;
  String totaltime;
  Object? deptid;
  Map<String, dynamic>? params;
  Object? steps;
  Object? originalcnid;
  String submittime;
  Object? district;
  String customercreatetime;
  Object? identificationurl;
  String credittime;
  int loanid;
  int status;
  Object? city;
  Object? csage;
  int origin;
  int cnid;
  String remark;
  int realamount;
  int curuserid;
  String accountmanager;
  String updateby;
  Object? supercreatetime;
  int housearea;
  List<Circulations>? circulations;
  Object? abandontime;
  String bankbranch;
  Object? deedurl;
  String updatetime;
  String staff;
  int userid;
  int loanamount;
  Object? createby;
  String csname;
  String createtime;
  Object? searchvalue;
  Object? loanrate;
  String houseaddress;
  int   bankid;
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
    'bankId': bankid,
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
    this.params,
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
    params: json.containsKey('params')
        ? asT<Map<String, dynamic>?>(json['params'])
        : null,
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
  Map<String, dynamic>? params;
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

class Circulations {
  Circulations({
    required this.owner,
    required this.timeconsuming,
    this.cnid,
    this.deedurl,
    this.updatetime,
    this.remark,
    this.owners,
    this.params,
    required this.createby,
    this.creditid,
    required this.circulationid,
    required this.createtime,
    this.updateby,
    this.identificationurl,
    required this.step,
    this.credit,
    this.searchvalue,
    required this.loanid,
    required this.status,
  });

  factory Circulations.fromJson(Map<String, dynamic> json) => Circulations(
    owner: json.containsKey('owner') ? asT<int>(json['owner'])! : 0,
    timeconsuming: json.containsKey('timeConsuming')
        ? asT<String>(json['timeConsuming'])!
        : '',
    cnid: json.containsKey('cnId') ? asT<Object?>(json['cnId']) : null,
    deedurl:
    json.containsKey('deedUrl') ? asT<Object?>(json['deedUrl']) : null,
    updatetime: json.containsKey('updateTime')
        ? asT<Object?>(json['updateTime'])
        : null,
    remark:
    json.containsKey('remark') ? asT<Object?>(json['remark']) : null,
    owners:
    json.containsKey('owners') ? asT<Object?>(json['owners']) : null,
    params: json.containsKey('params')
        ? asT<Map<String, dynamic>?>(json['params'])
        : null,
    createby:
    json.containsKey('createBy') ? asT<String>(json['createBy'])! : '',
    creditid:
    json.containsKey('creditId') ? asT<int?>(json['creditId']) : null,
    circulationid: json.containsKey('circulationId')
        ? asT<int>(json['circulationId'])!
        : 0,
    createtime: json.containsKey('createTime')
        ? asT<String>(json['createTime'])!
        : '',
    updateby: json.containsKey('updateBy')
        ? asT<String?>(json['updateBy'])
        : null,
    identificationurl: json.containsKey('identificationUrl')
        ? asT<String?>(json['identificationUrl'])
        : null,
    step: json.containsKey('step') ? asT<int>(json['step'])! : 0,
    credit: json.containsKey('credit')
        ? json['credit'] == null
        ? null
        : Credit.fromJson(asT<Map<String, dynamic>>(json['credit'])!)
        : null,
    searchvalue: json.containsKey('searchValue')
        ? asT<Object?>(json['searchValue'])
        : null,
    loanid: json.containsKey('loanId') ? asT<int>(json['loanId'])! : 0,
    status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
  );

  int owner;
  String timeconsuming;
  Object? cnid;
  Object? deedurl;
  Object? updatetime;
  Object? remark;
  Object? owners;
  Map<String, dynamic>? params;
  String createby;
  int? creditid;
  int circulationid;
  String createtime;
  String? updateby;
  String? identificationurl;
  int step;
  Credit? credit;
  Object? searchvalue;
  int loanid;
  int status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'owner': owner,
    'timeConsuming': timeconsuming,
    'cnId': cnid,
    'deedUrl': deedurl,
    'updateTime': updatetime,
    'remark': remark,
    'owners': owners,
    'params': params,
    'createBy': createby,
    'creditId': creditid,
    'circulationId': circulationid,
    'createTime': createtime,
    'updateBy': updateby,
    'identificationUrl': identificationurl,
    'step': step,
    'credit': credit,
    'searchValue': searchvalue,
    'loanId': loanid,
    'status': status,
  };
}

class Credit {
  Credit({
    required this.createby,
    required this.createtime,
    required this.creditamount,
    required this.creditid,
    required this.cumulativeamount,
    required this.loanid,
    this.params,
    this.remark,
    this.searchvalue,
    this.updateby,
    this.updatetime,
  });

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
    createby:
    json.containsKey('createBy') ? asT<String>(json['createBy'])! : '',
    createtime: json.containsKey('createTime')
        ? asT<String>(json['createTime'])!
        : '',
    creditamount: json.containsKey('creditAmount')
        ? asT<int>(json['creditAmount'])!
        : 0,
    creditid:
    json.containsKey('creditId') ? asT<int>(json['creditId'])! : 0,
    cumulativeamount: json.containsKey('cumulativeAmount')
        ? asT<int>(json['cumulativeAmount'])!
        : 0,
    loanid: json.containsKey('loanId') ? asT<int>(json['loanId'])! : 0,
    params: json.containsKey('params')
        ? asT<Map<String, dynamic>?>(json['params'])
        : null,
    remark:
    json.containsKey('remark') ? asT<Object?>(json['remark']) : null,
    searchvalue: json.containsKey('searchValue')
        ? asT<Object?>(json['searchValue'])
        : null,
    updateby: json.containsKey('updateBy')
        ? asT<Object?>(json['updateBy'])
        : null,
    updatetime: json.containsKey('updateTime')
        ? asT<Object?>(json['updateTime'])
        : null,
  );

  String createby;
  String createtime;
  int creditamount;
  int creditid;
  int cumulativeamount;
  int loanid;
  Map<String, dynamic>? params;
  Object? remark;
  Object? searchvalue;
  Object? updateby;
  Object? updatetime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'createBy': createby,
    'createTime': createtime,
    'creditAmount': creditamount,
    'creditId': creditid,
    'cumulativeAmount': cumulativeamount,
    'loanId': loanid,
    'params': params,
    'remark': remark,
    'searchValue': searchvalue,
    'updateBy': updateby,
    'updateTime': updatetime,
  };
}
