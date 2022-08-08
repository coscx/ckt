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

class LoginEntity {
  LoginEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
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
    required this.token,
    required this.user,
    required this.imToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json.containsKey('token')
        ? json['token'] == null
        ? null
        : Token.fromJson(asT<Map<String, dynamic>>(json['token'])!)
        : null,
    user: json.containsKey('user')
        ? json['user'] == null
        ? null
        : User.fromJson(asT<Map<String, dynamic>>(json['user'])!)
        : null,
    imToken:
    json.containsKey('im_token') ? asT<String>(json['im_token'])! : '',
  );

  Token? token;
  User? user;
  String imToken;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'user': user,
    'im_token': imToken,
  };
}

class Token {
  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json.containsKey('access_token')
        ? asT<String>(json['access_token'])!
        : '',
    refreshToken: json.containsKey('refresh_token')
        ? asT<String>(json['refresh_token'])!
        : '',
  );

  String accessToken;
  String refreshToken;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}

class User {
  User({
    required this.accessToken,
    required this.refreshToken,
    required this.relname,
    required this.uuid,
    required this.openid,
    required this.id,
    required this.mobile,
    required this.avatar,
    required this.idcardVerified,
    required this.messageCount,
    required this.roleId,
    required this.roleName,
    required this.roleKey,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    accessToken: json.containsKey('access_token')
        ? asT<String>(json['access_token'])!
        : '',
    refreshToken: json.containsKey('refresh_token')
        ? asT<String>(json['refresh_token'])!
        : '',
    relname:
    json.containsKey('relname') ? asT<String>(json['relname'])! : '',
    uuid: json.containsKey('uuid') ? asT<String>(json['uuid'])! : '',
    openid: json.containsKey('openid') ? asT<String>(json['openid'])! : '',
    id: json.containsKey('id') ? asT<int>(json['id'])! : 0,
    mobile: json.containsKey('mobile') ? asT<String>(json['mobile'])! : '',
    avatar: json.containsKey('avatar') ? asT<String>(json['avatar'])! : '',
    idcardVerified: json.containsKey('idcard_verified')
        ? asT<int>(json['idcard_verified'])!
        : 0,
    messageCount: json.containsKey('message_count')
        ? asT<int>(json['message_count'])!
        : 0,
    roleName: json.containsKey('role_name') ? asT<String>(json['role_name'])! : '',
    roleId: json.containsKey('role_id') ? asT<int>(json['role_id'])! : 0,
    roleKey: json.containsKey('role_key') ? asT<String>(json['role_key'])! : '',
  );

  String accessToken;
  String refreshToken;
  String relname;
  String uuid;
  String openid;
  int id;
  String mobile;
  String avatar;
  int idcardVerified;
  int messageCount;
  int roleId;
  String roleName;
  String roleKey;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'relname': relname,
    'uuid': uuid,
    'openid': openid,
    'id': id,
    'mobile': mobile,
    'avatar': avatar,
    'idcard_verified': idcardVerified,
    'message_count': messageCount,
    'role_id': roleId,
    'role_name': roleName,
    'role_key': roleKey,
  };
}
