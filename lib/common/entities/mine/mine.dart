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

class DashBordDataResult {
  DashBordDataResult({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory DashBordDataResult.fromJson(Map<String, dynamic> json) =>
      DashBordDataResult(
        code: asT<int>(json['code'])!,
        data: DashBordData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  DashBordData data;
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

class DashBordData {
  DashBordData({
    required this.todo,
    required this.top,
    required this.userPhoto,
  });

  factory DashBordData.fromJson(Map<String, dynamic> json) => DashBordData(
    todo: Todo.fromJson(asT<Map<String, dynamic>>(json['todo'])!),
    top: Top.fromJson(asT<Map<String, dynamic>>(json['top'])!),
    userPhoto:
    UserPhoto.fromJson(asT<Map<String, dynamic>>(json['user_photo'])!),
  );

  Todo todo;
  Top top;
  UserPhoto userPhoto;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'todo': todo,
    'top': top,
    'user_photo': userPhoto,
  };
}

class Todo {
  Todo({
    required this.soonDrop,
    required this.todayDrop,
    required this.todayFollow,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    soonDrop: asT<int>(json['soon_drop'])!,
    todayDrop: asT<int>(json['today_drop'])!,
    todayFollow: asT<int>(json['today_follow'])!,
  );

  int soonDrop;
  int todayDrop;
  int todayFollow;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'soon_drop': soonDrop,
    'today_drop': todayDrop,
    'today_follow': todayFollow,
  };
}

class Top {
  Top({
    required this.yesterdayConnect,
    required this.yesterdayCreate,
    required this.yesterdayLost,
  });

  factory Top.fromJson(Map<String, dynamic> json) => Top(
    yesterdayConnect: asT<int>(json['yesterday_connect'])!,
    yesterdayCreate: asT<int>(json['yesterday_create'])!,
    yesterdayLost: asT<int>(json['yesterday_lost'])!,
  );

  int yesterdayConnect;
  int yesterdayCreate;
  int yesterdayLost;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'yesterday_connect': yesterdayConnect,
    'yesterday_create': yesterdayCreate,
    'yesterday_lost': yesterdayLost,
  };
}

class UserPhoto {
  UserPhoto({
    required this.age,
    required this.gender,
    required this.income,
    required this.industry,
  });

  factory UserPhoto.fromJson(Map<String, dynamic> json) {
    final List<Gender>? gender = json['gender'] is List ? <Gender>[] : null;
    if (gender != null) {
      for (final dynamic item in json['gender']!) {
        if (item != null) {
          tryCatch(() {
            gender.add(Gender.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return UserPhoto(
      age: Age.fromJson(asT<Map<String, dynamic>>(json['age'])!),
      gender: gender!,
      income: Income.fromJson(asT<Map<String, dynamic>>(json['income'])!),
      industry: Industry.fromJson(asT<Map<String, dynamic>>(json['industry'])!),
    );
  }

  Age age;
  List<Gender> gender;
  Income income;
  Industry industry;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'age': age,
    'gender': gender,
    'income': income,
    'industry': industry,
  };
}

class Age {
  Age({
    required this.data,
    required this.name,
  });

  factory Age.fromJson(Map<String, dynamic> json) {
    final List<int>? data = json['data'] is List ? <int>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<String>? name = json['name'] is List ? <String>[] : null;
    if (name != null) {
      for (final dynamic item in json['name']!) {
        if (item != null) {
          tryCatch(() {
            name.add(asT<String>(item)!);
          });
        }
      }
    }
    return Age(
      data: data!,
      name: name!,
    );
  }

  List<int> data;
  List<String> name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'name': name,
  };
}

class Gender {
  Gender({
    required this.name,
    required this.value,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    name: asT<String>(json['name'])!,
    value: asT<int>(json['value'])!,
  );

  String name;
  int value;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'value': value,
  };
}

class Income {
  Income({
    required this.data,
    required this.name,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    final List<int>? data = json['data'] is List ? <int>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<String>? name = json['name'] is List ? <String>[] : null;
    if (name != null) {
      for (final dynamic item in json['name']!) {
        if (item != null) {
          tryCatch(() {
            name.add(asT<String>(item)!);
          });
        }
      }
    }
    return Income(
      data: data!,
      name: name!,
    );
  }

  List<int> data;
  List<String> name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'name': name,
  };
}

class Industry {
  Industry({
    required this.data,
    required this.name,
  });

  factory Industry.fromJson(Map<String, dynamic> json) {
    final List<int>? data = json['data'] is List ? <int>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<String>? name = json['name'] is List ? <String>[] : null;
    if (name != null) {
      for (final dynamic item in json['name']!) {
        if (item != null) {
          tryCatch(() {
            name.add(asT<String>(item)!);
          });
        }
      }
    }
    return Industry(
      data: data!,
      name: name!,
    );
  }

  List<int> data;
  List<String> name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'name': name,
  };
}
