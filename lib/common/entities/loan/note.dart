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

class Note {
  Note({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    code: json.containsKey('code') ? asT<int>(json['code'])! : 0,
    data: json.containsKey('data')
        ? json['data'] == null
        ? null
        : NoteData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null,
    msg: json.containsKey('msg') ? asT<String>(json['msg'])! : '',
  );

  int code;
  NoteData? data;
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

class NoteData {
  NoteData({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory NoteData.fromJson(Map<String, dynamic> json) {
    final List<NoteDataData>? data =
    json['data'] is List ? <NoteDataData>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(NoteDataData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return NoteData(
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
  List<NoteDataData>? data;
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

class NoteDataData {
  NoteDataData({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.addtime,
    required this.dateTime,
  });

  factory NoteDataData.fromJson(Map<String, dynamic> json) => NoteDataData(
    id: json.containsKey('id') ? asT<int>(json['id'])! : 0,
    userId: json.containsKey('user_id') ? asT<int>(json['user_id'])! : 0,
    title: json.containsKey('title') ? asT<String>(json['title'])! : '',
    content:
    json.containsKey('content') ? asT<String>(json['content'])! : '',
    addtime: json.containsKey('addtime') ? asT<int>(json['addtime'])! : 0,
    dateTime: json.containsKey('date_time')
        ? asT<String>(json['date_time'])!
        : '',
  );

  int id;
  int userId;
  String title;
  String content;
  int addtime;
  String dateTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'user_id': userId,
    'title': title,
    'content': content,
    'addtime': addtime,
    'date_time': dateTime,
  };
}
