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

  return defaultValue;
}

class WxArticleEntity {
  WxArticleEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory WxArticleEntity.fromJson(Map<String, dynamic> json) =>
      WxArticleEntity(
        code: asT<int>(json['code'])!,
        data: Data.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  Data data;
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
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<Datas>? data = json['data'] is List ? <Datas>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(Datas.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      currentPage: asT<int>(json['current_page'])!,
      data: data!,
      lastPage: asT<int>(json['last_page'])!,
      total: asT<int>(json['total'])!,
    );
  }

  int currentPage;
  List<Datas> data;
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

class Datas {
  Datas({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.birth,
    required this.age,
    required this.gender,
    required this.status,
    required this.storeId,
    required this.store,
    required this.createId,
    required this.createName,
    required this.title,
    required this.url,
    required this.img,
    required this.uuid,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
    id: asT<int>(json['id'])!,
    customerId: asT<int>(json['customer_id'])!,
    customerName: asT<String>(json['customer_name'])!,
    birth: asT<int>(json['birth'])!,
    age: asT<int>(json['age'])!,
    gender: asT<int>(json['gender'])!,
    status: asT<int>(json['status'])!,
    storeId: asT<int>(json['store_id'])!,
    store: asT<String>(json['store'])!,
    createId: asT<int>(json['create_id'])!,
    createName: asT<String>(json['create_name'])!,
    title: asT<String>(json['title'])!,
    url: asT<String>(json['url'])!,
    img: asT<String>(json['img'])!,
    uuid: asT<String>(json['uuid'])!,
    updatedAt: asT<String>(json['updated_at'])!,
    createdAt: asT<String>(json['created_at'])!,
  );

  int id;
  int customerId;
  String customerName;
  int birth;
  int age;
  int gender;
  int status;
  int storeId;
  String store;
  int createId;
  String createName;
  String title;
  String url;
  String img;
  String uuid;
  String updatedAt;
  String createdAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'customer_id': customerId,
    'customer_name': customerName,
    'birth': birth,
    'age': age,
    'gender': gender,
    'status': status,
    'store_id': storeId,
    'store': store,
    'create_id': createId,
    'create_name': createName,
    'title': title,
    'url': url,
    'img': img,
    'uuid': uuid,
    'updated_at': updatedAt,
    'created_at': createdAt,
  };
}
