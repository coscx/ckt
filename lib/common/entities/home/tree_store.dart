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

class TreeStoreResult {
  TreeStoreResult({
    required this.status,
    required this.code,
    required this.data,
  });

  factory TreeStoreResult.fromJson(Map<String, dynamic> json) {
    final List<TreeStore>? data = json['data'] is List ? <TreeStore>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(TreeStore.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return TreeStoreResult(
      status: asT<String>(json['status'])!,
      code: asT<int>(json['code'])!,
      data: data!,
    );
  }

  String status;
  int code;
  List<TreeStore> data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'code': code,
    'data': data,
  };
}

class TreeStore {
  TreeStore({
    required this.name,
    required this.cityCode,
    required this.parentId,
    required this.data,
  });

  factory TreeStore.fromJson(Map<String, dynamic> json) {
    final List<Data>? data = json['data'] is List ? <Data>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(Data.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return TreeStore(
      name: asT<String>(json['name'])!,
      cityCode: asT<String>(json['city_code'])!,
      parentId: asT<int>(json['parent_id'])!,
      data: data!,
    );
  }

  String name;
  String cityCode;
  int parentId;
  List<Data> data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'city_code': cityCode,
    'parent_id': parentId,
    'data': data,
  };
}

class Data {
  Data({
    required this.parentId,
    required this.id,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    parentId: asT<int>(json['parent_id'])!,
    id: asT<int>(json['id'])!,
    name: asT<String>(json['name'])!,
  );

  int parentId;
  int id;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'parent_id': parentId,
    'id': id,
    'name': name,
  };
}
