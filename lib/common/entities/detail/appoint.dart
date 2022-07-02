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

class AppointDataResult {
  AppointDataResult({
    required this.msg,
    required this.code,
    required this.data,
  });

  factory AppointDataResult.fromJson(Map<String, dynamic> json) =>
      AppointDataResult(
        msg: asT<String>(json['msg'])!,
        code: asT<int>(json['code'])!,
        data: AppointData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
      );

  String msg;
  int code;
  AppointData data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'msg': msg,
    'code': code,
    'data': data,
  };
}

class AppointData {
  AppointData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory AppointData.fromJson(Map<String, dynamic> json) {
    final List<Appoint>? data = json['data'] is List ? <Appoint>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(Appoint.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AppointData(
      currentPage: asT<int>(json['current_page'])!,
      data: data!,
      firstPageUrl: asT<String>(json['first_page_url'])!,
      from: asT<int>(json['from'])!,
      lastPage: asT<int>(json['last_page'])!,
      lastPageUrl: asT<String>(json['last_page_url'])!,
      nextPageUrl: asT<Object?>(json['next_page_url']),
      path: asT<String>(json['path'])!,
      perPage: asT<int>(json['per_page'])!,
      prevPageUrl: asT<Object?>(json['prev_page_url']),
      to: asT<int>(json['to'])!,
      total: asT<int>(json['total'])!,
    );
  }

  int currentPage;
  List<Appoint> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Object? nextPageUrl;
  String path;
  int perPage;
  Object? prevPageUrl;
  int to;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'current_page': currentPage,
    'data': data,
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class Appoint {
  Appoint({
    required this.id,
    required this.userId,
    required this.username,
    required this.otherName,
    required this.otherId,
    required this.appointmentTime,
    required this.appointmentAddress,
    required this.remark,
    this.message,
    this.score1,
    this.feedback1,
    required this.createdAt,
    required this.system,
    required this.mark,
    required this.type,
    required this.isPay,
    required this.canWrite,
  });

  factory Appoint.fromJson(Map<String, dynamic> json) => Appoint(
    id: asT<int>(json['id'])!,
    userId: asT<int>(json['user_id'])!,
    username: asT<String>(json['username'])!,
    otherName: asT<String>(json['other_name'])!,
    otherId: asT<int>(json['other_id'])!,
    appointmentTime: asT<String>(json['appointment_time'])!,
    appointmentAddress: asT<String>(json['appointment_address'])!,
    remark: asT<String>(json['remark'])!,
    message: asT<Object?>(json['message']),
    score1: asT<Object?>(json['score1']),
    feedback1: asT<Object?>(json['feedback1']),
    createdAt: asT<String>(json['created_at'])!,
    system: asT<int>(json['system'])!,
    mark: asT<int>(json['mark'])!,
    type: asT<int>(json['type'])!,
    isPay: asT<int>(json['is_pay'])!,
    canWrite: asT<int>(json['can_write'])!,
  );

  int id;
  int userId;
  String username;
  String otherName;
  int otherId;
  String appointmentTime;
  String appointmentAddress;
  String remark;
  Object? message;
  Object? score1;
  Object? feedback1;
  String createdAt;
  int system;
  int mark;
  int type;
  int isPay;
  int canWrite;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'user_id': userId,
    'username': username,
    'other_name': otherName,
    'other_id': otherId,
    'appointment_time': appointmentTime,
    'appointment_address': appointmentAddress,
    'remark': remark,
    'message': message,
    'score1': score1,
    'feedback1': feedback1,
    'created_at': createdAt,
    'system': system,
    'mark': mark,
    'type': type,
    'is_pay': isPay,
    'can_write': canWrite,
  };
}
