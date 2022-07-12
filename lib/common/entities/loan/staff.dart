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

class Staff {
  Staff({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : StaffData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  StaffData? data;
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

class StaffData {
  StaffData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) {
    final List<StaffDataData>? data =
    json['data'] is List ? <StaffDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(StaffDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return StaffData(
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
  List<StaffDataData>? data;
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

class StaffDataData {
  StaffDataData({
    required this.roles,
    this.phonenumber,
    this.cnid,
    this.logindate,
    required this.admin,
    this.remark,
    this.delflag,
    this.updateby,
    this.postids,
    this.loginip,
    this.email,
    this.clientid,
    required this.nickname,
    this.roleid,
    this.sex,
    this.deptid,
    this.updatetime,
    this.avatar,
    this.dept,
    required this.params,
    this.username,
    required this.userid,
    this.createby,
    this.roleids,
    this.createtime,
    this.searchvalue,
    this.status,
  });

  factory StaffDataData.fromJson(Map<String, dynamic> json) {
    final List<Object>? roles = json['roles'] is List ? <Object>[] : null;
    if (roles != null) {
      for (final dynamic item in json['roles']!) {
        if (item != null) {
          tryCatch(() {
            roles.add(asT<Object>(item)!);
          });
        }
      }
    }
    return StaffDataData(
      roles: roles,
      phonenumber: json.containsKey('phonenumber')
          ? asT<Object?>(json['phonenumber'])
          : null,
      cnid: json.containsKey('cnId') ? asT<Object?>(json['cnId']) : null,
      logindate: json.containsKey('loginDate')
          ? asT<Object?>(json['loginDate'])
          : null,
      admin: json.containsKey('admin') ? asT<bool>(json['admin'])! : false,
      remark: json.containsKey('remark') ? asT<Object?>(json['remark']) : null,
      delflag:
      json.containsKey('delFlag') ? asT<Object?>(json['delFlag']) : null,
      updateby:
      json.containsKey('updateBy') ? asT<Object?>(json['updateBy']) : null,
      postids:
      json.containsKey('postIds') ? asT<Object?>(json['postIds']) : null,
      loginip:
      json.containsKey('loginIp') ? asT<Object?>(json['loginIp']) : null,
      email: json.containsKey('email') ? asT<Object?>(json['email']) : null,
      clientid:
      json.containsKey('clientId') ? asT<Object?>(json['clientId']) : null,
      nickname:
      json.containsKey('nickName') ? asT<String>(json['nickName'])! : '',
      roleid: json.containsKey('roleId') ? asT<Object?>(json['roleId']) : null,
      sex: json.containsKey('sex') ? asT<Object?>(json['sex']) : null,
      deptid: json.containsKey('deptId') ? asT<Object?>(json['deptId']) : null,
      updatetime: json.containsKey('updateTime')
          ? asT<Object?>(json['updateTime'])
          : null,
      avatar: json.containsKey('avatar') ? asT<Object?>(json['avatar']) : null,
      dept: json.containsKey('dept') ? asT<Object?>(json['dept']) : null,
      params: json.containsKey('params') ? asT<Object>(json['params'])! : null,
      username:
      json.containsKey('userName') ? asT<Object?>(json['userName']) : null,
      userid: json.containsKey('userId') ? asT<int>(json['userId'])! : 0,
      createby:
      json.containsKey('createBy') ? asT<Object?>(json['createBy']) : null,
      roleids:
      json.containsKey('roleIds') ? asT<Object?>(json['roleIds']) : null,
      createtime: json.containsKey('createTime')
          ? asT<Object?>(json['createTime'])
          : null,
      searchvalue: json.containsKey('searchValue')
          ? asT<Object?>(json['searchValue'])
          : null,
      status: json.containsKey('status') ? asT<Object?>(json['status']) : null,
    );
  }

  List<Object>? roles;
  Object? phonenumber;
  Object? cnid;
  Object? logindate;
  bool admin;
  Object? remark;
  Object? delflag;
  Object? updateby;
  Object? postids;
  Object? loginip;
  Object? email;
  Object? clientid;
  String nickname;
  Object? roleid;
  Object? sex;
  Object? deptid;
  Object? updatetime;
  Object? avatar;
  Object? dept;
  Object? params;
  Object? username;
  int userid;
  Object? createby;
  Object? roleids;
  Object? createtime;
  Object? searchvalue;
  Object? status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'roles': roles,
    'phonenumber': phonenumber,
    'cnId': cnid,
    'loginDate': logindate,
    'admin': admin,
    'remark': remark,
    'delFlag': delflag,
    'updateBy': updateby,
    'postIds': postids,
    'loginIp': loginip,
    'email': email,
    'clientId': clientid,
    'nickName': nickname,
    'roleId': roleid,
    'sex': sex,
    'deptId': deptid,
    'updateTime': updatetime,
    'avatar': avatar,
    'dept': dept,
    'params': params,
    'userName': username,
    'userId': userid,
    'createBy': createby,
    'roleIds': roleids,
    'createTime': createtime,
    'searchValue': searchvalue,
    'status': status,
  };
}
