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

class Channels {
  Channels({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Channels.fromJson(Map<String, dynamic> json) => Channels(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : ChannelData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  ChannelData? data;
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

class ChannelData {
  ChannelData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory ChannelData.fromJson(Map<String, dynamic> json) {
    final List<ChannelDataData>? data =
    json['data'] is List ? <ChannelDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(
                ChannelDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ChannelData(
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
  List<ChannelDataData>? data;
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

class ChannelDataData {
  ChannelDataData({
    required this.cntype,
    required this.code,
    required this.ascription,
    required this.cncode,
    required this.origin,
    required this.cnid,
    required this.deptid,
    this.updatetime,
    required this.remark,
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

  factory ChannelDataData.fromJson(Map<String, dynamic> json) =>
      ChannelDataData(
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
        remark: json.containsKey('remark') ? asT<String>(json['remark'])! : '',
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
  String remark;
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
