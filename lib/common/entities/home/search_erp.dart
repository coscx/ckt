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

class HomeEntity {
  HomeEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory HomeEntity.fromJson(Map<String, dynamic> json) => HomeEntity(
    code: asT<int>(json['code'])!,
    data: Datas.fromJson(asT<Map<String, dynamic>>(json['data'])!),
    msg: asT<String>(json['msg'])!,
  );

  int code;
  Datas data;
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

  HomeEntity copy() {
    return HomeEntity(
      code: code,
      data: data.copy(),
      msg: msg,
    );
  }
}

class Datas {
  Datas({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory Datas.fromJson(Map<String, dynamic> json) {
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
    return Datas(
      currentPage: asT<int>(json['current_page'])!,
      data: data!=null ?data :[],
      lastPage: asT<int>(json['last_page'])!,
      total: asT<int>(json['total'])!,
    );
  }

  int currentPage;
  List<Data> data;
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

  Datas copy() {
    return Datas(
      currentPage: currentPage,
      data: data.map((Data e) => e.copy()).toList(),
      lastPage: lastPage,
      total: total,
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.uuid,
    required this.storeId,
    required this.vipId,
    required this.storeName,
    required this.userId,
    required this.serveId,
    required this.status,
    required this.code,
    required this.name,
    required this.headImg,
    required this.gender,
    required this.createId,
    required this.createName,
    required this.saleName,
    required this.serveName,
    required this.vipName,
    required this.connectStatus,
    required this.serveStatus,
    required this.connectCount,
    required this.appointmentCount,
    required this.age,
    required this.height,
    required this.weight,
    required this.channel,
    required this.education,
    required this.marriage,
    required this.income,
    required this.hasHouse,
    required this.hasCar,
    required this.avatar,
    required this.nickname,
    required this.isPassive,
    required this.isTop,
    required this.npCityCode,
    required this.npAreaCode,
    required this.npProvinceName,
    required this.npCityName,
    required this.npAreaName,
    required this.npProvinceCode,
    required this.spreadType,
    required this.spreadId,
    required this.spreadAnme,
    required this.applyTypes,
    required this.vipExpireTime,
    required this.esAge,
    required this.birthday,
    required this.createdAt,
    required this.lastConnectTime,
    required this.actionTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: asT<int>(json['id'])!,
    uuid: asT<String>(json['uuid'])!,
    storeId: asT<int>(json['store_id'])!,
    vipId: asT<int>(json['vip_id'])!,
    storeName: asT<String>(json['store_name'])!,
    userId: asT<int>(json['user_id'])!,
    serveId: asT<int>(json['serve_id'])!,
    status: asT<int>(json['status'])!,
    code: asT<String>(json['code'])!,
    name: asT<String>(json['name'])!,
    headImg: asT<String>(json['head_img'])!,
    gender: asT<int>(json['gender'])!,
    createId: asT<int>(json['create_id'])!,
    createName: asT<String>(json['create_name'])!,
    saleName: asT<String>(json['sale_name'])!,
    serveName: asT<String>(json['serve_name'])!,
    vipName: asT<String>(json['vip_name'])!,
    connectStatus: asT<int>(json['connect_status'])!,
    serveStatus: asT<int>(json['serve_status'])!,
    connectCount: asT<int>(json['connect_count'])!,
    appointmentCount: asT<int>(json['appointment_count'])!,
    age: asT<int>(json['age'])!,
    height: asT<int>(json['height'])!,
    weight: asT<int>(json['weight'])!,
    channel: asT<int>(json['channel'])!,
    education: asT<int>(json['education'])!,
    marriage: asT<int>(json['marriage'])!,
    income: asT<int>(json['income'])!,
    hasHouse: asT<int>(json['has_house'])!,
    hasCar: asT<int>(json['has_car'])!,
    avatar: asT<String>(json['avatar'])!,
    nickname: asT<String>(json['nickname'])!,
    isPassive: asT<int>(json['is_passive'])!,
    isTop: asT<int>(json['is_top'])!,
    npCityCode: asT<String>(json['np_city_code'])!,
    npAreaCode: asT<String>(json['np_area_code'])!,
    npProvinceName: asT<String>(json['np_province_name'])!,
    npCityName: asT<String>(json['np_city_name'])!,
    npAreaName: asT<String>(json['np_area_name'])!,
    npProvinceCode: asT<String>(json['np_province_code'])!,
    spreadType: asT<int>(json['spread_type'])!,
    spreadId: asT<int>(json['spread_id'])!,
    spreadAnme: asT<String>(json['spread_anme'])!,
    applyTypes: asT<int>(json['apply_types'])!,
    vipExpireTime: asT<String>(json['vip_expire_time'])!,
    esAge: asT<String>(json['es_age'])!,
    birthday: asT<String>(json['birthday'])!,
    createdAt: asT<String>(json['created_at'])!,
    lastConnectTime: asT<String>(json['last_connect_time'])!,
    actionTime: asT<String>(json['action_time'])!,
  );

  int id;
  String uuid;
  int storeId;
  int vipId;
  String storeName;
  int userId;
  int serveId;
  int status;
  String code;
  String name;
  String headImg;
  int gender;
  int createId;
  String createName;
  String saleName;
  String serveName;
  String vipName;
  int connectStatus;
  int serveStatus;
  int connectCount;
  int appointmentCount;
  int age;
  int height;
  int weight;
  int channel;
  int education;
  int marriage;
  int income;
  int hasHouse;
  int hasCar;
  String avatar;
  String nickname;
  int isPassive;
  int isTop;
  String npCityCode;
  String npAreaCode;
  String npProvinceName;
  String npCityName;
  String npAreaName;
  String npProvinceCode;
  int spreadType;
  int spreadId;
  String spreadAnme;
  int applyTypes;
  String vipExpireTime;
  String esAge;
  String birthday;
  String createdAt;
  String lastConnectTime;
  String actionTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uuid': uuid,
    'store_id': storeId,
    'vip_id': vipId,
    'store_name': storeName,
    'user_id': userId,
    'serve_id': serveId,
    'status': status,
    'code': code,
    'name': name,
    'head_img': headImg,
    'gender': gender,
    'create_id': createId,
    'create_name': createName,
    'sale_name': saleName,
    'serve_name': serveName,
    'vip_name': vipName,
    'connect_status': connectStatus,
    'serve_status': serveStatus,
    'connect_count': connectCount,
    'appointment_count': appointmentCount,
    'age': age,
    'height': height,
    'weight': weight,
    'channel': channel,
    'education': education,
    'marriage': marriage,
    'income': income,
    'has_house': hasHouse,
    'has_car': hasCar,
    'avatar': avatar,
    'nickname': nickname,
    'is_passive': isPassive,
    'is_top': isTop,
    'np_city_code': npCityCode,
    'np_area_code': npAreaCode,
    'np_province_name': npProvinceName,
    'np_city_name': npCityName,
    'np_area_name': npAreaName,
    'np_province_code': npProvinceCode,
    'spread_type': spreadType,
    'spread_id': spreadId,
    'spread_anme': spreadAnme,
    'apply_types': applyTypes,
    'vip_expire_time': vipExpireTime,
    'es_age': esAge,
    'birthday': birthday,
    'created_at': createdAt,
    'last_connect_time': lastConnectTime,
    'action_time': actionTime,
  };

  Data copy() {
    return Data(
      id: id,
      uuid: uuid,
      storeId: storeId,
      vipId: vipId,
      storeName: storeName,
      userId: userId,
      serveId: serveId,
      status: status,
      code: code,
      name: name,
      headImg: headImg,
      gender: gender,
      createId: createId,
      createName: createName,
      saleName: saleName,
      serveName: serveName,
      vipName: vipName,
      connectStatus: connectStatus,
      serveStatus: serveStatus,
      connectCount: connectCount,
      appointmentCount: appointmentCount,
      age: age,
      height: height,
      weight: weight,
      channel: channel,
      education: education,
      marriage: marriage,
      income: income,
      hasHouse: hasHouse,
      hasCar: hasCar,
      avatar: avatar,
      nickname: nickname,
      isPassive: isPassive,
      isTop: isTop,
      npCityCode: npCityCode,
      npAreaCode: npAreaCode,
      npProvinceName: npProvinceName,
      npCityName: npCityName,
      npAreaName: npAreaName,
      npProvinceCode: npProvinceCode,
      spreadType: spreadType,
      spreadId: spreadId,
      spreadAnme: spreadAnme,
      applyTypes: applyTypes,
      vipExpireTime: vipExpireTime,
      esAge: esAge,
      birthday: birthday,
      createdAt: createdAt,
      lastConnectTime: lastConnectTime,
      actionTime: actionTime,
    );
  }
}
