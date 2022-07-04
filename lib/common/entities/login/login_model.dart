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



class LoginEntity {
  LoginEntity({
     this.status,
     this.code,
     this.data,
     this.message
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    status: asT<String>(json['status'])!,
    code: asT<int>(json['code'])!,
    data: json.containsKey('data')? Data.fromJson(asT<Map<String, dynamic>>(json['data'])!):null,
    message: json.containsKey('message')? asT<String>(json['message'])! :"",
  );

  String? status;
  int? code;
  Data? data;
  String? message;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'code': code,
    'data': data,
    'message': message,
  };
}

class Data {
  Data({
    required this.user,
    required this.token,
    required this.imToken,
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
    required this.avatar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(asT<Map<String, dynamic>>(json['user'])!),
    token: Token.fromJson(asT<Map<String, dynamic>>(json['token'])!),
    imToken: asT<String>(json['im_token'])!,
    tokenType: asT<String>(json['token_type'])!,
    expiresIn: asT<int>(json['expires_in'])!,
    accessToken: asT<String>(json['access_token'])!,
    refreshToken: asT<String>(json['refresh_token'])!,
    avatar: asT<String>(json['avatar'])!,
  );

  User user;
  Token token;
  String imToken;
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;
  String avatar;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user': user,
    'token': token,
    'im_token': imToken,
    'token_type': tokenType,
    'expires_in': expiresIn,
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'avatar': avatar,
  };
}

class User {
  User({
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
    this.unionid,
    required this.relname,
    required this.idcard,
    required this.idcardVerified,
    required this.lastLoginAt,
    required this.lastLoginIp,
    required this.isFirst,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.secret,
    required this.dataScope,
    required this.userType,
    required this.dataType,
    required this.commonType,
    required this.ccId,
    required this.qiyu,
    required this.appOpenid,
    required this.store,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final List<Store>? store = json['store'] is List ? <Store>[] : null;
    if (store != null) {
      for (final dynamic item in json['store']!) {
        if (item != null) {
          tryCatch(() {
            store.add(Store.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return User(
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
      unionid: asT<Object?>(json['unionid']),
      relname: asT<String>(json['relname'])!,
      idcard: asT<String>(json['idcard'])!,
      idcardVerified: asT<int>(json['idcard_verified'])!,
      lastLoginAt: asT<String>(json['last_login_at'])!,
      lastLoginIp: asT<String>(json['last_login_ip'])!,
      isFirst: asT<int>(json['is_first'])!,
      status: asT<int>(json['status'])!,
      createdAt: asT<String>(json['created_at'])!,
      updatedAt: asT<String>(json['updated_at'])!,
      secret: asT<String>(json['secret'])!,
      dataScope: asT<int>(json['data_scope'])!,
      userType: asT<int>(json['user_type'])!,
      dataType: asT<int>(json['data_type'])!,
      commonType: asT<int>(json['common_type'])!,
      ccId: asT<int>(json['cc_id'])!,
      qiyu: asT<String>(json['qiyu'])!,
      appOpenid: asT<String>(json['app_openid'])!,
      store: store!,
    );
  }

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
  Object? unionid;
  String relname;
  String idcard;
  int idcardVerified;
  String lastLoginAt;
  String lastLoginIp;
  int isFirst;
  int status;
  String createdAt;
  String updatedAt;
  String secret;
  int dataScope;
  int userType;
  int dataType;
  int commonType;
  int ccId;
  String qiyu;
  String appOpenid;
  List<Store> store;

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
    'created_at': createdAt,
    'updated_at': updatedAt,
    'secret': secret,
    'data_scope': dataScope,
    'user_type': userType,
    'data_type': dataType,
    'common_type': commonType,
    'cc_id': ccId,
    'qiyu': qiyu,
    'app_openid': appOpenid,
    'store': store,
  };
}

class Store {
  Store({
    required this.storeId,
    required this.storeName,
    required this.expireTime,
    required this.pivot,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    storeId: asT<int>(json['store_id'])!,
    storeName: asT<String>(json['store_name'])!,
    expireTime: asT<String>(json['expire_time'])!,
    pivot: Pivot.fromJson(asT<Map<String, dynamic>>(json['pivot'])!),
  );

  int storeId;
  String storeName;
  String expireTime;
  Pivot pivot;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'store_id': storeId,
    'store_name': storeName,
    'expire_time': expireTime,
    'pivot': pivot,
  };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.storeId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: asT<int>(json['user_id'])!,
    storeId: asT<int>(json['store_id'])!,
  );

  int userId;
  int storeId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user_id': userId,
    'store_id': storeId,
  };
}

class Token {
  Token({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    tokenType: asT<String>(json['token_type'])!,
    expiresIn: asT<int>(json['expires_in'])!,
    accessToken: asT<String>(json['access_token'])!,
    refreshToken: asT<String>(json['refresh_token'])!,
  );

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token_type': tokenType,
    'expires_in': expiresIn,
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}
