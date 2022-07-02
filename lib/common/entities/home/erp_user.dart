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

class ErpUserResult {
  ErpUserResult({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory ErpUserResult.fromJson(Map<String, dynamic> json) {
    final List<ErpUser>? data = json['data'] is List ? <ErpUser>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(ErpUser.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ErpUserResult(
      code: asT<int>(json['code'])!,
      data: data!,
      msg: asT<String>(json['msg'])!,
    );
  }

  int code;
  List<ErpUser> data;
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

class ErpUser {
  ErpUser({
    required this.id,
    required this.uuid,
    required this.departmentId,
    required this.mobile,
    required this.mobileVerified,
    required this.notificationCount,
    required this.messageCount,
    required this.avatar,
    required this.nickname,
    required this.openid,
    required this.unionid,
    required this.relname,
    required this.idcard,
    required this.idcardVerified,
    required this.lastLoginAt,
    required this.lastLoginIp,
    required this.isFirst,
    required this.status,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.secret,
    required this.dataScope,
    required this.userType,
    required this.dataType,
    required this.commonType,
    this.store,
    required this.ccId,
  });

  factory ErpUser.fromJson(Map<String, dynamic> json) => ErpUser(
    id: asT<int>(json['id'])!,
    uuid: asT<String>(json['uuid'])!,
    departmentId: asT<int>(json['department_id'])!,
    mobile: asT<String>(json['mobile'])!,
    mobileVerified: asT<int>(json['mobile_verified'])!,
    notificationCount: asT<int>(json['notification_count'])!,
    messageCount: asT<int>(json['message_count'])!,
    avatar: asT<String>(json['avatar'])!,
    nickname: asT<String>(json['nickname'])!,
    openid: asT<String>(json['openid'])!,
    unionid: asT<String>(json['unionid'])!,
    relname: asT<String>(json['relname'])!,
    idcard: asT<String>(json['idcard'])!,
    idcardVerified: asT<int>(json['idcard_verified'])!,
    lastLoginAt: asT<String>(json['last_login_at'])!,
    lastLoginIp: asT<String>(json['last_login_ip'])!,
    isFirst: asT<int>(json['is_first'])!,
    status: asT<int>(json['status'])!,
    password: asT<String>(json['password'])!,
    rememberToken: asT<String>(json['remember_token'])!,
    createdAt: asT<String>(json['created_at'])!,
    updatedAt: asT<String>(json['updated_at'])!,
    secret: asT<String>(json['secret'])!,
    dataScope: asT<int>(json['data_scope'])!,
    userType: asT<int>(json['user_type'])!,
    dataType: asT<int>(json['data_type'])!,
    commonType: asT<int>(json['common_type'])!,
    store: asT<Object?>(json['store']),
    ccId: asT<int>(json['cc_id'])!,
  );

  int id;
  String uuid;
  int departmentId;
  String mobile;
  int mobileVerified;
  int notificationCount;
  int messageCount;
  String avatar;
  String nickname;
  String openid;
  String unionid;
  String relname;
  String idcard;
  int idcardVerified;
  String lastLoginAt;
  String lastLoginIp;
  int isFirst;
  int status;
  String password;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String secret;
  int dataScope;
  int userType;
  int dataType;
  int commonType;
  Object? store;
  int ccId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uuid': uuid,
    'department_id': departmentId,
    'mobile': mobile,
    'mobile_verified': mobileVerified,
    'notification_count': notificationCount,
    'message_count': messageCount,
    'avatar': avatar,
    'nickname': nickname,
    'openid': openid,
    'unionid': unionid,
    'relname': relname,
    'idcard': idcard,
    'idcard_verified': idcardVerified,
    'last_login_at': lastLoginAt,
    'last_login_ip': lastLoginIp,
    'is_first': isFirst,
    'status': status,
    'password': password,
    'remember_token': rememberToken,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'secret': secret,
    'data_scope': dataScope,
    'user_type': userType,
    'data_type': dataType,
    'common_type': commonType,
    'store': store,
    'cc_id': ccId,
  };
}
