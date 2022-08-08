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

class Abandon {
  Abandon({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Abandon.fromJson(Map<String, dynamic> json) => Abandon(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : AbandonData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  AbandonData? data;
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

class AbandonData {
  AbandonData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory AbandonData.fromJson(Map<String, dynamic> json) {
    final List<AbandonDataData>? data =
    json['data'] is List ? <AbandonDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(
                AbandonDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AbandonData(
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
  List<AbandonDataData>? data;
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

class AbandonDataData {
  AbandonDataData({
    required this.csphone,
    this.channel,
    this.divisionname,
    this.directorcreatetime,
    required this.binduserid,
    required this.loancycle,
    required this.division,
    required this.paytype,
    this.province,
    this.incomingtime,
    this.cumulativeamount,
    this.superid,
    this.credit,
    required this.decoration,
    required this.curstaff,
    this.directorid,
    required this.totaltime,
    this.deptid,
    required this.params,
    this.steps,
    this.originalcnid,
    this.submittime,
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
    required this.remark,
    this.realamount,
    required this.curuserid,
    this.accountmanager,
    required this.updateby,
    this.supercreatetime,
    required this.housearea,
    this.circulations,
    required this.abandontime,
    this.bankbranch,
    this.deedurl,
    required this.updatetime,
    this.staff,
    required this.userid,
    required this.loanamount,
    this.createby,
    required this.csname,
    required this.createtime,
    this.searchvalue,
    required this.loanrate,
    required this.houseaddress,
  });

  factory AbandonDataData.fromJson(Map<String, dynamic> json) =>
      AbandonDataData(
        csphone:
        json.containsKey('csPhone') ? asT<String>(json['csPhone'])! : '',
        channel:
        json.containsKey('channel') ? asT<Object?>(json['channel']) : null,
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
        paytype: json.containsKey('payType') ? asT<int>(json['payType'])! : 0,
        province: json.containsKey('province')
            ? asT<Object?>(json['province'])
            : null,
        incomingtime: json.containsKey('incomingTime')
            ? asT<Object?>(json['incomingTime'])
            : null,
        cumulativeamount: json.containsKey('cumulativeAmount')
            ? asT<Object?>(json['cumulativeAmount'])
            : null,
        superid:
        json.containsKey('superId') ? asT<Object?>(json['superId']) : null,
        credit:
        json.containsKey('credit') ? asT<Object?>(json['credit']) : null,
        decoration:
        json.containsKey('decoration') ? asT<int>(json['decoration'])! : 0,
        curstaff:
        json.containsKey('curStaff') ? asT<String>(json['curStaff'])! : '',
        directorid: json.containsKey('directorId')
            ? asT<Object?>(json['directorId'])
            : null,
        totaltime: json.containsKey('totalTime')
            ? asT<String>(json['totalTime'])!
            : '',
        deptid:
        json.containsKey('deptId') ? asT<Object?>(json['deptId']) : null,
        params:
        json.containsKey('params') ? asT<Object>(json['params'])! : null,
        steps: json.containsKey('steps') ? asT<Object?>(json['steps']) : null,
        originalcnid: json.containsKey('originalCnId')
            ? asT<Object?>(json['originalCnId'])
            : null,
        submittime: json.containsKey('submitTime')
            ? asT<Object?>(json['submitTime'])
            : null,
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
        remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
        realamount: json.containsKey('realAmount')
            ? asT<Object?>(json['realAmount'])
            : null,
        curuserid:
        json.containsKey('curUserId') ? asT<int>(json['curUserId'])! : 0,
        accountmanager: json.containsKey('accountManager')
            ? asT<Object?>(json['accountManager'])
            : null,
        updateby:
        json.containsKey('updateBy') ? asT<String>(json['updateBy'])! : '',
        supercreatetime: json.containsKey('superCreateTime')
            ? asT<Object?>(json['superCreateTime'])
            : null,
        housearea:
        json.containsKey('houseArea') ? asT<int>(json['houseArea'])! : 0,
        circulations: json.containsKey('circulations')
            ? asT<Object?>(json['circulations'])
            : null,
        abandontime: json.containsKey('abandonTime')
            ? asT<String>(json['abandonTime'])!
            : '',
        bankbranch: json.containsKey('bankBranch')
            ? asT<Object?>(json['bankBranch'])
            : null,
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
        loanrate:
        json.containsKey('loanRate') ? asT<int>(json['loanRate'])! : 0,
        houseaddress: json.containsKey('houseAddress')
            ? asT<String>(json['houseAddress'])!
            : '',
      );

  String csphone;
  Object? channel;
  Object? divisionname;
  Object? directorcreatetime;
  int binduserid;
  int loancycle;
  int division;
  int paytype;
  Object? province;
  Object? incomingtime;
  Object? cumulativeamount;
  Object? superid;
  Object? credit;
  int decoration;
  String curstaff;
  Object? directorid;
  String totaltime;
  Object? deptid;
  Object? params;
  Object? steps;
  Object? originalcnid;
  Object? submittime;
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
  String remark;
  Object? realamount;
  int curuserid;
  Object? accountmanager;
  String updateby;
  Object? supercreatetime;
  int housearea;
  Object? circulations;
  String abandontime;
  Object? bankbranch;
  Object? deedurl;
  String updatetime;
  Object? staff;
  int userid;
  int loanamount;
  Object? createby;
  String csname;
  String createtime;
  Object? searchvalue;
  int loanrate;
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
