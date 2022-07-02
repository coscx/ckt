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

  return defaultValue;
}

class UserDataResult {
  UserDataResult({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory UserDataResult.fromJson(Map<String, dynamic> json) => UserDataResult(
    code: asT<int>(json['code'])!,
    data: UserData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
    msg: asT<String>(json['msg'])!,
  );

  int code;
  UserData data;
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

class UserData {
  UserData({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final List<User>? data = json['data'] is List ? <User>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(User.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return UserData(
      currentPage: asT<int>(json['current_page'])!,
      data: data!,
      from: asT<int>(json['from'])!,
      lastPage: asT<int>(json['last_page'])!,
      perPage: asT<int>(json['per_page'])!,
      to: asT<int>(json['to'])!,
      total: asT<int>(json['total'])!,
    );
  }

  int currentPage;
  List<User> data;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'current_page': currentPage,
    'data': data,
    'from': from,
    'last_page': lastPage,
    'per_page': perPage,
    'to': to,
    'total': total,
  };
}

class User {
  User({
    required this.id,
    required this.uuid,
    required this.departmentId,
    required this.mobile,
    required this.departName,
    required this.storeName,
    required this.avatar,
    required this.relname,
    required this.idcardVerified,
    required this.lastLoginIp,
    required this.status,
    required this.wechatBind,
    required this.code,
    required this.dataScope,
    required this.userType,
    required this.dataType,
    required this.roleId,
    required this.storeId,
    required this.commonType,
    required this.lastLoginAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: asT<int>(json['id'])!,
    uuid: asT<String>(json['uuid'])!,
    departmentId: asT<int>(json['department_id'])!,
    mobile: asT<String>(json['mobile'])!,
    departName: asT<String>(json['depart_name'])!,
    storeName: asT<String>(json['store_name'])!,
    avatar: asT<String>(json['avatar'])!,
    relname: asT<String>(json['relname'])!,
    idcardVerified: asT<int>(json['idcard_verified'])!,
    lastLoginIp: asT<String>(json['last_login_ip'])!,
    status: asT<int>(json['status'])!,
    wechatBind: asT<int>(json['wechat_bind'])!,
    code: asT<String>(json['code'])!,
    dataScope: asT<String>(json['data_scope'])!,
    userType: asT<String>(json['user_type'])!,
    dataType: asT<String>(json['data_type'])!,
    roleId: asT<int>(json['role_id'])!,
    storeId: asT<int>(json['store_id'])!,
    commonType: asT<int>(json['common_type'])!,
    lastLoginAt: asT<String>(json['last_login_at'])!,
  );

  int id;
  String uuid;
  int departmentId;
  String mobile;
  String departName;
  String storeName;
  String avatar;
  String relname;
  int idcardVerified;
  String lastLoginIp;
  int status;
  int wechatBind;
  String code;
  String dataScope;
  String userType;
  String dataType;
  int roleId;
  int storeId;
  int commonType;
  String lastLoginAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uuid': uuid,
    'department_id': departmentId,
    'mobile': mobile,
    'depart_name': departName,
    'store_name': storeName,
    'avatar': avatar,
    'relname': relname,
    'idcard_verified': idcardVerified,
    'last_login_ip': lastLoginIp,
    'status': status,
    'wechat_bind': wechatBind,
    'code': code,
    'data_scope': dataScope,
    'user_type': userType,
    'data_type': dataType,
    'role_id': roleId,
    'store_id': storeId,
    'common_type': commonType,
    'last_login_at': lastLoginAt,
  };
}
