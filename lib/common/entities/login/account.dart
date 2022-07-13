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

class AccountData {
  AccountData({
    required this.account,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    final List<Account>? account = json['account'] is List ? <Account>[] : null;
    if (account != null) {
      for (final dynamic item in json['account']!) {
        if (item != null) {
          tryCatch(() {
            account.add(Account.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AccountData(
      account: account,
    );
  }

  List<Account>? account;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'account': account,
  };
}

class Account {
  Account({
    required this.imSender,
    required this.name,
    required this.uuid,
    required this.openid,
    required this.userToken,
    required this.freshToken,
    required this.memberid,
    required this.imToken,
    required this.avatar,
    required this.roleid,
    required this.mobile,
    required this.messageCount,
    required this.roleId,
    required this.roleName,
    required this.roleKey
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    imSender: json.containsKey('im_sender')
        ? asT<String>(json['im_sender'])!
        : '',
    name: json.containsKey('name') ? asT<String>(json['name'])! : '',
    uuid: json.containsKey('uuid') ? asT<String>(json['uuid'])! : '',
    openid: json.containsKey('openid') ? asT<String>(json['openid'])! : '',
    userToken: json.containsKey('user_token')
        ? asT<String>(json['user_token'])!
        : '',
    freshToken: json.containsKey('fresh_token')
        ? asT<String>(json['fresh_token'])!
        : '',
    memberid:
    json.containsKey('memberId') ? asT<String>(json['memberId'])! : '',
    imToken:
    json.containsKey('im_token') ? asT<String>(json['im_token'])! : '',
    avatar: json.containsKey('avatar') ? asT<String>(json['avatar'])! : '',
    roleid: json.containsKey('roleId') ? asT<String>(json['roleId'])! : '',
    mobile: json.containsKey('mobile') ? asT<String>(json['mobile'])! : '',
    messageCount: json.containsKey('message_count') ? asT<int>(json['message_count'])! : 0,
    roleName: json.containsKey('role_name') ? asT<String>(json['role_name'])! : '',
    roleId: json.containsKey('role_id') ? asT<int>(json['role_id'])! : 0,
    roleKey: json.containsKey('role_key') ? asT<String>(json['role_key'])! : '',
  );

  String imSender;
  String name;
  String uuid;
  String openid;
  String userToken;
  String freshToken;
  String memberid;
  String imToken;
  String avatar;
  String roleid;
  String mobile;
  int messageCount;
  int roleId;
  String roleName;
  String roleKey;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'im_sender': imSender,
    'name': name,
    'uuid': uuid,
    'openid': openid,
    'user_token': userToken,
    'fresh_token': freshToken,
    'memberId': memberid,
    'im_token': imToken,
    'avatar': avatar,
    'roleId': roleid,
    'mobile': mobile,
    'message_count': messageCount,
    'role_id': roleId,
    'role_name': roleName,
    'role_key':roleKey
  };
}
