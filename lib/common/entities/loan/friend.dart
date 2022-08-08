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

class Friend {
  Friend({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : FriendData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  FriendData? data;
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

class FriendData {
  FriendData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory FriendData.fromJson(Map<String, dynamic> json) {
    final List<FriendDataData>? data =
    json['data'] is List ? <FriendDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(FriendDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FriendData(
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
  List<FriendDataData>? data;
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

class FriendDataData {
  FriendDataData({
    required this.userId,
    required this.deptId,
    required this.userName,
    required this.nickName,
    required this.userType,
    required this.email,
    required this.phonenumber,
    required this.sex,
    required this.avatar,
    required this.password,
    required this.status,
    required this.delFlag,
    required this.loginIp,
    required this.loginDate,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
    required this.remark,
  });

  factory FriendDataData.fromJson(Map<String, dynamic> json) => FriendDataData(
    userId: json.containsKey('user_id') ? asT<int>(json['user_id'])! : 0,
    deptId: json.containsKey('dept_id') ? asT<int>(json['dept_id'])! : 0,
    userName: json.containsKey('user_name')
        ? asT<String>(json['user_name'])!
        : '',
    nickName: json.containsKey('nick_name')
        ? asT<String>(json['nick_name'])!
        : '',
    userType: json.containsKey('user_type')
        ? asT<String>(json['user_type'])!
        : '',
    email: json.containsKey('email') ? asT<String>(json['email'])! : '',
    phonenumber: json.containsKey('phonenumber')
        ? asT<String>(json['phonenumber'])!
        : '',
    sex: json.containsKey('sex') ? asT<int>(json['sex'])! : 0,
    avatar: json.containsKey('avatar') ? asT<String>(json['avatar'])! : '',
    password:
    json.containsKey('password') ? asT<String>(json['password'])! : '',
    status: json.containsKey('status') ? asT<int>(json['status'])! : 0,
    delFlag: json.containsKey('del_flag') ? asT<int>(json['del_flag'])! : 0,
    loginIp:
    json.containsKey('login_ip') ? asT<String>(json['login_ip'])! : '',
    loginDate: json.containsKey('login_date')
        ? asT<String>(json['login_date'])!
        : '',
    createBy: json.containsKey('create_by')
        ? asT<String>(json['create_by'])!
        : '',
    createTime: json.containsKey('create_time')
        ? asT<String>(json['create_time'])!
        : '',
    updateBy: json.containsKey('update_by')
        ? asT<String>(json['update_by'])!
        : '',
    updateTime: json.containsKey('update_time')
        ? asT<String>(json['update_time'])!
        : '',
    remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
  );

  int userId;
  int deptId;
  String userName;
  String nickName;
  String userType;
  String email;
  String phonenumber;
  int sex;
  String avatar;
  String password;
  int status;
  int delFlag;
  String loginIp;
  String loginDate;
  String createBy;
  String createTime;
  String updateBy;
  String updateTime;
  String remark;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user_id': userId,
    'dept_id': deptId,
    'user_name': userName,
    'nick_name': nickName,
    'user_type': userType,
    'email': email,
    'phonenumber': phonenumber,
    'sex': sex,
    'avatar': avatar,
    'password': password,
    'status': status,
    'del_flag': delFlag,
    'login_ip': loginIp,
    'login_date': loginDate,
    'create_by': createBy,
    'create_time': createTime,
    'update_by': updateBy,
    'update_time': updateTime,
    'remark': remark,
  };
}
