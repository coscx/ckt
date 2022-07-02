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

class UserDetailResult {
  UserDetailResult({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory UserDetailResult.fromJson(Map<String, dynamic> json) =>
      UserDetailResult(
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
    required this.canEdit,
    required this.canViewCall,
    required this.demand,
    required this.info,
    required this.label,
    required this.pay,
    required this.pic,
    required this.pics,
    required this.progress,
    required this.verified,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<Object>? label = json['label'] is List ? <Object>[] : null;
    if (label != null) {
      for (final dynamic item in json['label']!) {
        if (item != null) {
          tryCatch(() {
            label.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? pay = json['pay'] is List ? <Object>[] : null;
    if (pay != null) {
      for (final dynamic item in json['pay']!) {
        if (item != null) {
          tryCatch(() {
            pay.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<String>? pic = json['pic'] is List ? <String>[] : null;
    if (pic != null) {
      for (final dynamic item in json['pic']!) {
        if (item != null) {
          tryCatch(() {
            pic.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Pics>? pics = json['pics'] is List ? <Pics>[] : null;
    if (pics != null) {
      for (final dynamic item in json['pics']!) {
        if (item != null) {
          tryCatch(() {
            pics.add(Pics.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      canEdit: asT<int>(json['can_edit'])!,
      canViewCall: asT<int>(json['can_view_call'])!,
      demand: Demand.fromJson(asT<Map<String, dynamic>>(json['demand'])!),
      info: Info.fromJson(asT<Map<String, dynamic>>(json['info'])!),
      label: label!,
      pay: pay!,
      pic: pic!,
      pics: pics!,
      progress: asT<double>(json['progress'])!,
      verified: Verified.fromJson(asT<Map<String, dynamic>>(json['verified'])!),
    );
  }

  int canEdit;
  int canViewCall;
  Demand demand;
  Info info;
  List<Object> label;
  List<Object> pay;
  List<String> pic;
  List<Pics> pics;
  double progress;
  Verified verified;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'can_edit': canEdit,
    'can_view_call': canViewCall,
    'demand': demand,
    'info': info,
    'label': label,
    'pay': pay,
    'pic': pic,
    'pics': pics,
    'progress': progress,
    'verified': verified,
  };
}

class Demand {
  Demand({
    required this.id,
    required this.customerId,
    required this.wishAges,
    required this.wishHeights,
    required this.wishWeights,
    required this.wishHpProvinceCode,
    required this.wishHpCityCode,
    required this.wishHpAreaCode,
    required this.wishHpProvinceName,
    required this.wishHpCityName,
    required this.wishHpAreaName,
    required this.wishNpProvinceCode,
    required this.wishNpCityCode,
    required this.wishNpAreaCode,
    required this.wishNpProvinceName,
    required this.wishNpCityName,
    required this.wishNpAreaName,
    required this.wishLpProvinceCode,
    required this.wishLpCityCode,
    required this.wishLpAreaCode,
    required this.wishLpProvinceName,
    required this.wishLpCityName,
    required this.wishLpAreaName,
    required this.wishEducation,
    required this.wishJob,
    required this.wishWork,
    required this.wishWorkOvertime,
    required this.wishMarriage,
    required this.wishWantChild,
    required this.wishAcceptChild,
    required this.wishMarryTime,
    required this.wishIncome,
    required this.wishHasHouse,
    required this.wishLoanRecord,
    required this.wishHasCar,
    required this.wishParents,
    required this.wishFaith,
    required this.wishSmoke,
    required this.wishDrinkwine,
    required this.wishChineseZodiac,
    required this.wishZodiac,
    required this.createdAt,
    required this.updatedAt,
    required this.wishBody,
    required this.description,
  });

  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
    id: asT<int>(json['id'])!,
    customerId: asT<int>(json['customer_id'])!,
    wishAges: asT<String>(json['wish_ages'])!,
    wishHeights: asT<String>(json['wish_heights'])!,
    wishWeights: asT<String>(json['wish_weights'])!,
    wishHpProvinceCode: asT<String>(json['wish_hp_province_code'])!,
    wishHpCityCode: asT<String>(json['wish_hp_city_code'])!,
    wishHpAreaCode: asT<String>(json['wish_hp_area_code'])!,
    wishHpProvinceName: asT<String>(json['wish_hp_province_name'])!,
    wishHpCityName: asT<String>(json['wish_hp_city_name'])!,
    wishHpAreaName: asT<String>(json['wish_hp_area_name'])!,
    wishNpProvinceCode: asT<String>(json['wish_np_province_code'])!,
    wishNpCityCode: asT<String>(json['wish_np_city_code'])!,
    wishNpAreaCode: asT<String>(json['wish_np_area_code'])!,
    wishNpProvinceName: asT<String>(json['wish_np_province_name'])!,
    wishNpCityName: asT<String>(json['wish_np_city_name'])!,
    wishNpAreaName: asT<String>(json['wish_np_area_name'])!,
    wishLpProvinceCode: asT<String>(json['wish_lp_province_code'])!,
    wishLpCityCode: asT<String>(json['wish_lp_city_code'])!,
    wishLpAreaCode: asT<String>(json['wish_lp_area_code'])!,
    wishLpProvinceName: asT<String>(json['wish_lp_province_name'])!,
    wishLpCityName: asT<String>(json['wish_lp_city_name'])!,
    wishLpAreaName: asT<String>(json['wish_lp_area_name'])!,
    wishEducation: asT<String>(json['wish_education'])!,
    wishJob: asT<String>(json['wish_job'])!,
    wishWork: asT<String>(json['wish_work'])!,
    wishWorkOvertime: asT<String>(json['wish_work_overtime'])!,
    wishMarriage: asT<String>(json['wish_marriage'])!,
    wishWantChild: asT<String>(json['wish_want_child'])!,
    wishAcceptChild: asT<String>(json['wish_accept_child'])!,
    wishMarryTime: asT<String>(json['wish_marry_time'])!,
    wishIncome: asT<String>(json['wish_income'])!,
    wishHasHouse: asT<String>(json['wish_has_house'])!,
    wishLoanRecord: asT<String>(json['wish_loan_record'])!,
    wishHasCar: asT<String>(json['wish_has_car'])!,
    wishParents: asT<String>(json['wish_parents'])!,
    wishFaith: asT<String>(json['wish_faith'])!,
    wishSmoke: asT<String>(json['wish_smoke'])!,
    wishDrinkwine: asT<String>(json['wish_drinkwine'])!,
    wishChineseZodiac: asT<String>(json['wish_chinese_zodiac'])!,
    wishZodiac: asT<String>(json['wish_zodiac'])!,
    createdAt: asT<String>(json['created_at'])!,
    updatedAt: asT<String>(json['updated_at'])!,
    wishBody: asT<String>(json['wish_body'])!,
    description: asT<String>(json['description'])!,
  );

  int id;
  int customerId;
  String wishAges;
  String wishHeights;
  String wishWeights;
  String wishHpProvinceCode;
  String wishHpCityCode;
  String wishHpAreaCode;
  String wishHpProvinceName;
  String wishHpCityName;
  String wishHpAreaName;
  String wishNpProvinceCode;
  String wishNpCityCode;
  String wishNpAreaCode;
  String wishNpProvinceName;
  String wishNpCityName;
  String wishNpAreaName;
  String wishLpProvinceCode;
  String wishLpCityCode;
  String wishLpAreaCode;
  String wishLpProvinceName;
  String wishLpCityName;
  String wishLpAreaName;
  String wishEducation;
  String wishJob;
  String wishWork;
  String wishWorkOvertime;
  String wishMarriage;
  String wishWantChild;
  String wishAcceptChild;
  String wishMarryTime;
  String wishIncome;
  String wishHasHouse;
  String wishLoanRecord;
  String wishHasCar;
  String wishParents;
  String wishFaith;
  String wishSmoke;
  String wishDrinkwine;
  String wishChineseZodiac;
  String wishZodiac;
  String createdAt;
  String updatedAt;
  String wishBody;
  String description;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'customer_id': customerId,
    'wish_ages': wishAges,
    'wish_heights': wishHeights,
    'wish_weights': wishWeights,
    'wish_hp_province_code': wishHpProvinceCode,
    'wish_hp_city_code': wishHpCityCode,
    'wish_hp_area_code': wishHpAreaCode,
    'wish_hp_province_name': wishHpProvinceName,
    'wish_hp_city_name': wishHpCityName,
    'wish_hp_area_name': wishHpAreaName,
    'wish_np_province_code': wishNpProvinceCode,
    'wish_np_city_code': wishNpCityCode,
    'wish_np_area_code': wishNpAreaCode,
    'wish_np_province_name': wishNpProvinceName,
    'wish_np_city_name': wishNpCityName,
    'wish_np_area_name': wishNpAreaName,
    'wish_lp_province_code': wishLpProvinceCode,
    'wish_lp_city_code': wishLpCityCode,
    'wish_lp_area_code': wishLpAreaCode,
    'wish_lp_province_name': wishLpProvinceName,
    'wish_lp_city_name': wishLpCityName,
    'wish_lp_area_name': wishLpAreaName,
    'wish_education': wishEducation,
    'wish_job': wishJob,
    'wish_work': wishWork,
    'wish_work_overtime': wishWorkOvertime,
    'wish_marriage': wishMarriage,
    'wish_want_child': wishWantChild,
    'wish_accept_child': wishAcceptChild,
    'wish_marry_time': wishMarryTime,
    'wish_income': wishIncome,
    'wish_has_house': wishHasHouse,
    'wish_loan_record': wishLoanRecord,
    'wish_has_car': wishHasCar,
    'wish_parents': wishParents,
    'wish_faith': wishFaith,
    'wish_smoke': wishSmoke,
    'wish_drinkwine': wishDrinkwine,
    'wish_chinese_zodiac': wishChineseZodiac,
    'wish_zodiac': wishZodiac,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'wish_body': wishBody,
    'description': description,
  };
}

class Info {
  Info({
    required this.id,
    required this.uuid,
    required this.storeId,
    required this.userId,
    required this.serveId,
    required this.status,
    required this.code,
    required this.name,
    required this.appName,
    required this.headImg,
    required this.gender,
    required this.personalSignature,
    required this.vipId,
    required this.vipCount,
    required this.vipTime,
    required this.spreadType,
    required this.mobile,
    required this.spreadId,
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
    required this.parents,
    required this.hpCode,
    required this.hpCityCode,
    required this.hpAreaCode,
    required this.hpProvinceName,
    required this.hpCityName,
    required this.hpAreaName,
    required this.npProvinceCode,
    required this.npCityCode,
    required this.npAreaCode,
    required this.npProvinceName,
    required this.npCityName,
    required this.npAreaName,
    required this.lpProvinceCode,
    required this.lpCityCode,
    required this.lpAreaCode,
    required this.lpProvinceName,
    required this.lpCityName,
    required this.lpAreaName,
    required this.esAge,
    required this.esHeight,
    required this.esIncome,
    required this.esChannel,
    required this.esMarriage,
    required this.esArea,
    required this.esHouse,
    required this.esCar,
    required this.avatar,
    required this.nickname,
    required this.country,
    required this.province,
    required this.city,
    required this.openid,
    required this.unionid,
    required this.sessionKey,
    required this.money,
    required this.score,
    required this.notificationCount,
    required this.messageCount,
    required this.isInvisible,
    required this.againstTimes,
    required this.isSystemBlack,
    required this.isInvented,
    required this.isPassive,
    required this.passiveUserId,
    required this.passiveTime,
    required this.isFreeze,
    required this.lastActiveTime,
    required this.password,
    required this.updatedAt,
    required this.deletedAt,
    required this.intro,
    required this.sport,
    required this.food,
    required this.like,
    required this.friend,
    required this.partner,
    required this.esWork,
    required this.at,
    required this.fire,
    required this.fireName,
    required this.school,
    required this.industry,
    required this.zodiac,
    required this.vipExpire,
    required this.hasIdentity,
    required this.hasEducation,
    required this.isSubscribe,
    required this.officialAccountOpenid,
    required this.wechatAccount,
    required this.newFollowCount,
    required this.newVisitCount,
    required this.hasFollowTrends,
    required this.systemBlackTime,
    required this.logOffStatus,
    required this.smallId,
    required this.enrollId,
    required this.incomeOld,
    required this.stop,
    required this.vipRemainTime,
    required this.isSingle,
    required this.actionId,
    required this.byteOpenid,
    required this.byteUnionid,
    required this.byteSessionKey,
    required this.checked,
    required this.favourite,
    required this.single,
    required this.personal,
    required this.register,
    required this.hasSingle,
    required this.hasRegister,
    required this.hasPersonal,
    required this.topTime,
    required this.getCoin,
    required this.txCoin,
    required this.consumeCoin,
    required this.payCoin,
    required this.newVisitHerCount,
    required this.newHeartHerCount,
    required this.newHeartCount,
    required this.progress,
    required this.loveView,
    required this.inviteCoin,
    required this.scoreP,
    required this.parentsInsurance,
    required this.singleStatus,
    required this.idcard,
    required this.hasPhoto,
    required this.byte,
    required this.createId,
    required this.tags,
    required this.selectUser,
    required this.selectService,
    required this.selectStore,
    required this.applyTypes,
    required this.customerId,
    required this.selectUserName,
    required this.selectServiceName,
    required this.selectStoreName,
    required this.storeName,
    required this.appStoreName,
    required this.major,
    required this.work,
    required this.workIndustry,
    required this.workJob,
    required this.workOvertime,
    required this.hasChild,
    required this.childRemark,
    required this.wantChild,
    required this.loanRecord,
    required this.carType,
    required this.carRecord,
    required this.onlyChild,
    required this.fatherWork,
    required this.motherWork,
    required this.parentsIncome,
    required this.chineseZodiac,
    required this.bazi,
    required this.wuxing,
    required this.nation,
    required this.bloodType,
    required this.faith,
    required this.smoke,
    required this.drinkwine,
    required this.liveRest,
    required this.marryTime,
    required this.liveWithParents,
    required this.cooking,
    required this.household,
    required this.interest,
    required this.demands,
    required this.remark,
    required this.shareBackId,
    required this.shareBackPic,
    required this.frontCover,
    required this.customVip,
    required this.appVipId,
    required this.appVipLevelIcon,
    required this.vipName,
    required this.locationPlace,
    required this.nativePlace,
    required this.saleUser,
    required this.serveUser,
    required this.roleId,
    required this.birthday,
    required this.createdAt,
    required this.lastConnectTime,
    required this.actionTime,
    required this.vipExpireTime,
    required this.hitVipTime,
    required this.appVipExpire,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    final List<Object>? tags = json['tags'] is List ? <Object>[] : null;
    if (tags != null) {
      for (final dynamic item in json['tags']!) {
        if (item != null) {
          tryCatch(() {
            tags.add(asT<Object>(item)!);
          });
        }
      }
    }
    return Info(
      id: asT<int>(json['id'])!,
      uuid: asT<String>(json['uuid'])!,
      storeId: asT<int>(json['store_id'])!,
      userId: asT<int>(json['user_id'])!,
      serveId: asT<int>(json['serve_id'])!,
      status: asT<int>(json['status'])!,
      code: asT<String>(json['code'])!,
      name: asT<String>(json['name'])!,
      appName: asT<String>(json['app_name'])!,
      headImg: asT<String>(json['head_img'])!,
      gender: asT<int>(json['gender'])!,
      personalSignature: asT<String>(json['personal_signature'])!,
      vipId: asT<int>(json['vip_id'])!,
      vipCount: asT<int>(json['vip_count'])!,
      vipTime: asT<int>(json['vip_time'])!,
      spreadType: asT<int>(json['spread_type'])!,
      mobile: asT<String>(json['mobile'])!,
      spreadId: asT<int>(json['spread_id'])!,
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
      parents: asT<int>(json['parents'])!,
      hpCode: asT<String>(json['hp_code'])!,
      hpCityCode: asT<String>(json['hp_city_code'])!,
      hpAreaCode: asT<String>(json['hp_area_code'])!,
      hpProvinceName: asT<String>(json['hp_province_name'])!,
      hpCityName: asT<String>(json['hp_city_name'])!,
      hpAreaName: asT<String>(json['hp_area_name'])!,
      npProvinceCode: asT<String>(json['np_province_code'])!,
      npCityCode: asT<String>(json['np_city_code'])!,
      npAreaCode: asT<String>(json['np_area_code'])!,
      npProvinceName: asT<String>(json['np_province_name'])!,
      npCityName: asT<String>(json['np_city_name'])!,
      npAreaName: asT<String>(json['np_area_name'])!,
      lpProvinceCode: asT<String>(json['lp_province_code'])!,
      lpCityCode: asT<String>(json['lp_city_code'])!,
      lpAreaCode: asT<String>(json['lp_area_code'])!,
      lpProvinceName: asT<String>(json['lp_province_name'])!,
      lpCityName: asT<String>(json['lp_city_name'])!,
      lpAreaName: asT<String>(json['lp_area_name'])!,
      esAge: asT<String>(json['es_age'])!,
      esHeight: asT<String>(json['es_height'])!,
      esIncome: asT<String>(json['es_income'])!,
      esChannel: asT<String>(json['es_channel'])!,
      esMarriage: asT<String>(json['es_marriage'])!,
      esArea: asT<String>(json['es_area'])!,
      esHouse: asT<String>(json['es_house'])!,
      esCar: asT<String>(json['es_car'])!,
      avatar: asT<String>(json['avatar'])!,
      nickname: asT<String>(json['nickname'])!,
      country: asT<String>(json['country'])!,
      province: asT<String>(json['province'])!,
      city: asT<String>(json['city'])!,
      openid: asT<String>(json['openid'])!,
      unionid: asT<String>(json['unionid'])!,
      sessionKey: asT<String>(json['session_key'])!,
      money: asT<int>(json['money'])!,
      score: asT<int>(json['score'])!,
      notificationCount: asT<int>(json['notification_count'])!,
      messageCount: asT<int>(json['message_count'])!,
      isInvisible: asT<int>(json['is_invisible'])!,
      againstTimes: asT<int>(json['against_times'])!,
      isSystemBlack: asT<int>(json['is_system_black'])!,
      isInvented: asT<int>(json['is_invented'])!,
      isPassive: asT<int>(json['is_passive'])!,
      passiveUserId: asT<int>(json['passive_user_id'])!,
      passiveTime: asT<String>(json['passive_time'])!,
      isFreeze: asT<int>(json['is_freeze'])!,
      lastActiveTime: asT<String>(json['last_active_time'])!,
      password: asT<String>(json['password'])!,
      updatedAt: asT<String>(json['updated_at'])!,
      deletedAt: asT<String>(json['deleted_at'])!,
      intro: asT<String>(json['intro'])!,
      sport: asT<String>(json['sport'])!,
      food: asT<String>(json['food'])!,
      like: asT<String>(json['like'])!,
      friend: asT<String>(json['friend'])!,
      partner: asT<String>(json['partner'])!,
      esWork: asT<String>(json['es_work'])!,
      at: asT<int>(json['at'])!,
      fire: asT<int>(json['fire'])!,
      fireName: asT<String>(json['fire_name'])!,
      school: asT<String>(json['school'])!,
      industry: asT<int>(json['industry'])!,
      zodiac: asT<String>(json['zodiac'])!,
      vipExpire: asT<String>(json['vip_expire'])!,
      hasIdentity: asT<int>(json['has_identity'])!,
      hasEducation: asT<int>(json['has_education'])!,
      isSubscribe: asT<int>(json['is_subscribe'])!,
      officialAccountOpenid: asT<String>(json['official_account_openid'])!,
      wechatAccount: asT<String>(json['wechat_account'])!,
      newFollowCount: asT<int>(json['new_follow_count'])!,
      newVisitCount: asT<int>(json['new_visit_count'])!,
      hasFollowTrends: asT<int>(json['has_follow_trends'])!,
      systemBlackTime: asT<String>(json['system_black_time'])!,
      logOffStatus: asT<int>(json['log_off_status'])!,
      smallId: asT<int>(json['small_id'])!,
      enrollId: asT<int>(json['enroll_id'])!,
      incomeOld: asT<int>(json['income_old'])!,
      stop: asT<int>(json['stop'])!,
      vipRemainTime: asT<int>(json['vip_remain_time'])!,
      isSingle: asT<int>(json['is_single'])!,
      actionId: asT<int>(json['action_id'])!,
      byteOpenid: asT<String>(json['byte_openid'])!,
      byteUnionid: asT<String>(json['byte_unionid'])!,
      byteSessionKey: asT<String>(json['byte_session_key'])!,
      checked: asT<int>(json['checked'])!,
      favourite: asT<String>(json['favourite'])!,
      single: asT<String>(json['single'])!,
      personal: asT<String>(json['personal'])!,
      register: asT<String>(json['register'])!,
      hasSingle: asT<int>(json['has_single'])!,
      hasRegister: asT<int>(json['has_register'])!,
      hasPersonal: asT<int>(json['has_personal'])!,
      topTime: asT<int>(json['top_time'])!,
      getCoin: asT<int>(json['get_coin'])!,
      txCoin: asT<int>(json['tx_coin'])!,
      consumeCoin: asT<int>(json['consume_coin'])!,
      payCoin: asT<int>(json['pay_coin'])!,
      newVisitHerCount: asT<int>(json['new_visit_her_count'])!,
      newHeartHerCount: asT<int>(json['new_heart_her_count'])!,
      newHeartCount: asT<int>(json['new_heart_count'])!,
      progress: asT<int>(json['progress'])!,
      loveView: asT<String>(json['love_view'])!,
      inviteCoin: asT<int>(json['invite_coin'])!,
      scoreP: asT<int>(json['score_p'])!,
      parentsInsurance: asT<int>(json['parents_insurance'])!,
      singleStatus: asT<int>(json['single_status'])!,
      idcard: asT<String>(json['idcard'])!,
      hasPhoto: asT<int>(json['has_photo'])!,
      byte: asT<int>(json['byte'])!,
      createId: asT<int>(json['create_id'])!,
      tags: tags!,
      selectUser: asT<String>(json['select_user'])!,
      selectService: asT<String>(json['select_service'])!,
      selectStore: asT<String>(json['select_store'])!,
      applyTypes: asT<int>(json['apply_types'])!,
      customerId: asT<int>(json['customer_id'])!,
      selectUserName: asT<String>(json['select_user_name'])!,
      selectServiceName: asT<String>(json['select_service_name'])!,
      selectStoreName: asT<String>(json['select_store_name'])!,
      storeName: asT<String>(json['store_name'])!,
      appStoreName: asT<String>(json['app_store_name'])!,
      major: asT<String>(json['major'])!,
      work: asT<int>(json['work'])!,
      workIndustry: asT<String>(json['work_industry'])!,
      workJob: asT<int>(json['work_job'])!,
      workOvertime: asT<int>(json['work_overtime'])!,
      hasChild: asT<int>(json['has_child'])!,
      childRemark: asT<String>(json['child_remark'])!,
      wantChild: asT<int>(json['want_child'])!,
      loanRecord: asT<int>(json['loan_record'])!,
      carType: asT<int>(json['car_type'])!,
      carRecord: asT<int>(json['car_record'])!,
      onlyChild: asT<int>(json['only_child'])!,
      fatherWork: asT<String>(json['father_work'])!,
      motherWork: asT<String>(json['mother_work'])!,
      parentsIncome: asT<String>(json['parents_income'])!,
      chineseZodiac: asT<String>(json['chinese_zodiac'])!,
      bazi: asT<String>(json['bazi'])!,
      wuxing: asT<String>(json['wuxing'])!,
      nation: asT<int>(json['nation'])!,
      bloodType: asT<int>(json['blood_type'])!,
      faith: asT<int>(json['faith'])!,
      smoke: asT<int>(json['smoke'])!,
      drinkwine: asT<int>(json['drinkwine'])!,
      liveRest: asT<int>(json['live_rest'])!,
      marryTime: asT<int>(json['marry_time'])!,
      liveWithParents: asT<int>(json['live_with_parents'])!,
      cooking: asT<int>(json['cooking'])!,
      household: asT<int>(json['household'])!,
      interest: asT<String>(json['interest'])!,
      demands: asT<String>(json['demands'])!,
      remark: asT<String>(json['remark'])!,
      shareBackId: asT<int>(json['share_back_id'])!,
      shareBackPic: asT<String>(json['share_back_pic'])!,
      frontCover: asT<String>(json['front_cover'])!,
      customVip: asT<int>(json['custom_vip'])!,
      appVipId: asT<int>(json['app_vip_id'])!,
      appVipLevelIcon: asT<String>(json['app_vip_level_icon'])!,
      vipName: asT<String>(json['vip_name'])!,
      locationPlace: asT<String>(json['location_place'])!,
      nativePlace: asT<String>(json['native_place'])!,
      saleUser: asT<String>(json['sale_user'])!,
      serveUser: asT<String>(json['serve_user'])!,
      roleId: asT<int>(json['role_id'])!,
      birthday: asT<String>(json['birthday'])!,
      createdAt: asT<String>(json['created_at'])!,
      lastConnectTime: asT<String>(json['last_connect_time'])!,
      actionTime: asT<String>(json['action_time'])!,
      vipExpireTime: asT<String>(json['vip_expire_time'])!,
      hitVipTime: asT<String>(json['hit_vip_time'])!,
      appVipExpire: asT<String>(json['app_vip_expire'])!,
    );
  }

  int id;
  String uuid;
  int storeId;
  int userId;
  int serveId;
  int status;
  String code;
  String name;
  String appName;
  String headImg;
  int gender;
  String personalSignature;
  int vipId;
  int vipCount;
  int vipTime;
  int spreadType;
  String mobile;
  int spreadId;
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
  int parents;
  String hpCode;
  String hpCityCode;
  String hpAreaCode;
  String hpProvinceName;
  String hpCityName;
  String hpAreaName;
  String npProvinceCode;
  String npCityCode;
  String npAreaCode;
  String npProvinceName;
  String npCityName;
  String npAreaName;
  String lpProvinceCode;
  String lpCityCode;
  String lpAreaCode;
  String lpProvinceName;
  String lpCityName;
  String lpAreaName;
  String esAge;
  String esHeight;
  String esIncome;
  String esChannel;
  String esMarriage;
  String esArea;
  String esHouse;
  String esCar;
  String avatar;
  String nickname;
  String country;
  String province;
  String city;
  String openid;
  String unionid;
  String sessionKey;
  int money;
  int score;
  int notificationCount;
  int messageCount;
  int isInvisible;
  int againstTimes;
  int isSystemBlack;
  int isInvented;
  int isPassive;
  int passiveUserId;
  String passiveTime;
  int isFreeze;
  String lastActiveTime;
  String password;
  String updatedAt;
  String deletedAt;
  String intro;
  String sport;
  String food;
  String like;
  String friend;
  String partner;
  String esWork;
  int at;
  int fire;
  String fireName;
  String school;
  int industry;
  String zodiac;
  String vipExpire;
  int hasIdentity;
  int hasEducation;
  int isSubscribe;
  String officialAccountOpenid;
  String wechatAccount;
  int newFollowCount;
  int newVisitCount;
  int hasFollowTrends;
  String systemBlackTime;
  int logOffStatus;
  int smallId;
  int enrollId;
  int incomeOld;
  int stop;
  int vipRemainTime;
  int isSingle;
  int actionId;
  String byteOpenid;
  String byteUnionid;
  String byteSessionKey;
  int checked;
  String favourite;
  String single;
  String personal;
  String register;
  int hasSingle;
  int hasRegister;
  int hasPersonal;
  int topTime;
  int getCoin;
  int txCoin;
  int consumeCoin;
  int payCoin;
  int newVisitHerCount;
  int newHeartHerCount;
  int newHeartCount;
  int progress;
  String loveView;
  int inviteCoin;
  int scoreP;
  int parentsInsurance;
  int singleStatus;
  String idcard;
  int hasPhoto;
  int byte;
  int createId;
  List<Object> tags;
  String selectUser;
  String selectService;
  String selectStore;
  int applyTypes;
  int customerId;
  String selectUserName;
  String selectServiceName;
  String selectStoreName;
  String storeName;
  String appStoreName;
  String major;
  int work;
  String workIndustry;
  int workJob;
  int workOvertime;
  int hasChild;
  String childRemark;
  int wantChild;
  int loanRecord;
  int carType;
  int carRecord;
  int onlyChild;
  String fatherWork;
  String motherWork;
  String parentsIncome;
  String chineseZodiac;
  String bazi;
  String wuxing;
  int nation;
  int bloodType;
  int faith;
  int smoke;
  int drinkwine;
  int liveRest;
  int marryTime;
  int liveWithParents;
  int cooking;
  int household;
  String interest;
  String demands;
  String remark;
  int shareBackId;
  String shareBackPic;
  String frontCover;
  int customVip;
  int appVipId;
  String appVipLevelIcon;
  String vipName;
  String locationPlace;
  String nativePlace;
  String saleUser;
  String serveUser;
  int roleId;
  String birthday;
  String createdAt;
  String lastConnectTime;
  String actionTime;
  String vipExpireTime;
  String hitVipTime;
  String appVipExpire;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uuid': uuid,
    'store_id': storeId,
    'user_id': userId,
    'serve_id': serveId,
    'status': status,
    'code': code,
    'name': name,
    'app_name': appName,
    'head_img': headImg,
    'gender': gender,
    'personal_signature': personalSignature,
    'vip_id': vipId,
    'vip_count': vipCount,
    'vip_time': vipTime,
    'spread_type': spreadType,
    'mobile': mobile,
    'spread_id': spreadId,
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
    'parents': parents,
    'hp_code': hpCode,
    'hp_city_code': hpCityCode,
    'hp_area_code': hpAreaCode,
    'hp_province_name': hpProvinceName,
    'hp_city_name': hpCityName,
    'hp_area_name': hpAreaName,
    'np_province_code': npProvinceCode,
    'np_city_code': npCityCode,
    'np_area_code': npAreaCode,
    'np_province_name': npProvinceName,
    'np_city_name': npCityName,
    'np_area_name': npAreaName,
    'lp_province_code': lpProvinceCode,
    'lp_city_code': lpCityCode,
    'lp_area_code': lpAreaCode,
    'lp_province_name': lpProvinceName,
    'lp_city_name': lpCityName,
    'lp_area_name': lpAreaName,
    'es_age': esAge,
    'es_height': esHeight,
    'es_income': esIncome,
    'es_channel': esChannel,
    'es_marriage': esMarriage,
    'es_area': esArea,
    'es_house': esHouse,
    'es_car': esCar,
    'avatar': avatar,
    'nickname': nickname,
    'country': country,
    'province': province,
    'city': city,
    'openid': openid,
    'unionid': unionid,
    'session_key': sessionKey,
    'money': money,
    'score': score,
    'notification_count': notificationCount,
    'message_count': messageCount,
    'is_invisible': isInvisible,
    'against_times': againstTimes,
    'is_system_black': isSystemBlack,
    'is_invented': isInvented,
    'is_passive': isPassive,
    'passive_user_id': passiveUserId,
    'passive_time': passiveTime,
    'is_freeze': isFreeze,
    'last_active_time': lastActiveTime,
    'password': password,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'intro': intro,
    'sport': sport,
    'food': food,
    'like': like,
    'friend': friend,
    'partner': partner,
    'es_work': esWork,
    'at': at,
    'fire': fire,
    'fire_name': fireName,
    'school': school,
    'industry': industry,
    'zodiac': zodiac,
    'vip_expire': vipExpire,
    'has_identity': hasIdentity,
    'has_education': hasEducation,
    'is_subscribe': isSubscribe,
    'official_account_openid': officialAccountOpenid,
    'wechat_account': wechatAccount,
    'new_follow_count': newFollowCount,
    'new_visit_count': newVisitCount,
    'has_follow_trends': hasFollowTrends,
    'system_black_time': systemBlackTime,
    'log_off_status': logOffStatus,
    'small_id': smallId,
    'enroll_id': enrollId,
    'income_old': incomeOld,
    'stop': stop,
    'vip_remain_time': vipRemainTime,
    'is_single': isSingle,
    'action_id': actionId,
    'byte_openid': byteOpenid,
    'byte_unionid': byteUnionid,
    'byte_session_key': byteSessionKey,
    'checked': checked,
    'favourite': favourite,
    'single': single,
    'personal': personal,
    'register': register,
    'has_single': hasSingle,
    'has_register': hasRegister,
    'has_personal': hasPersonal,
    'top_time': topTime,
    'get_coin': getCoin,
    'tx_coin': txCoin,
    'consume_coin': consumeCoin,
    'pay_coin': payCoin,
    'new_visit_her_count': newVisitHerCount,
    'new_heart_her_count': newHeartHerCount,
    'new_heart_count': newHeartCount,
    'progress': progress,
    'love_view': loveView,
    'invite_coin': inviteCoin,
    'score_p': scoreP,
    'parents_insurance': parentsInsurance,
    'single_status': singleStatus,
    'idcard': idcard,
    'has_photo': hasPhoto,
    'byte': byte,
    'create_id': createId,
    'tags': tags,
    'select_user': selectUser,
    'select_service': selectService,
    'select_store': selectStore,
    'apply_types': applyTypes,
    'customer_id': customerId,
    'select_user_name': selectUserName,
    'select_service_name': selectServiceName,
    'select_store_name': selectStoreName,
    'store_name': storeName,
    'app_store_name': appStoreName,
    'major': major,
    'work': work,
    'work_industry': workIndustry,
    'work_job': workJob,
    'work_overtime': workOvertime,
    'has_child': hasChild,
    'child_remark': childRemark,
    'want_child': wantChild,
    'loan_record': loanRecord,
    'car_type': carType,
    'car_record': carRecord,
    'only_child': onlyChild,
    'father_work': fatherWork,
    'mother_work': motherWork,
    'parents_income': parentsIncome,
    'chinese_zodiac': chineseZodiac,
    'bazi': bazi,
    'wuxing': wuxing,
    'nation': nation,
    'blood_type': bloodType,
    'faith': faith,
    'smoke': smoke,
    'drinkwine': drinkwine,
    'live_rest': liveRest,
    'marry_time': marryTime,
    'live_with_parents': liveWithParents,
    'cooking': cooking,
    'household': household,
    'interest': interest,
    'demands': demands,
    'remark': remark,
    'share_back_id': shareBackId,
    'share_back_pic': shareBackPic,
    'front_cover': frontCover,
    'custom_vip': customVip,
    'app_vip_id': appVipId,
    'app_vip_level_icon': appVipLevelIcon,
    'vip_name': vipName,
    'location_place': locationPlace,
    'native_place': nativePlace,
    'sale_user': saleUser,
    'serve_user': serveUser,
    'role_id': roleId,
    'birthday': birthday,
    'created_at': createdAt,
    'last_connect_time': lastConnectTime,
    'action_time': actionTime,
    'vip_expire_time': vipExpireTime,
    'hit_vip_time': hitVipTime,
    'app_vip_expire': appVipExpire,
  };
}

class Pics {
  Pics({
    required this.id,
    required this.customerId,
    required this.type,
    required this.fileUrl,
    required this.sort,
    required this.isApproved,
  });

  factory Pics.fromJson(Map<String, dynamic> json) => Pics(
    id: asT<int>(json['id'])!,
    customerId: asT<int>(json['customer_id'])!,
    type: asT<int>(json['type'])!,
    fileUrl: asT<String>(json['file_url'])!,
    sort: asT<int>(json['sort'])!,
    isApproved: asT<int>(json['is_approved'])!,
  );

  int id;
  int customerId;
  int type;
  String fileUrl;
  int sort;
  int isApproved;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'customer_id': customerId,
    'type': type,
    'file_url': fileUrl,
    'sort': sort,
    'is_approved': isApproved,
  };
}

class Verified {
  Verified({
    required this.id,
    required this.customerId,
    required this.verifyUserId,
    required this.verifyUserName,
    required this.nameVerified,
    required this.name,
    required this.idcardVerified,
    required this.idcard,
    required this.idcardFront,
    required this.idcardBack,
    required this.educationVerified,
    required this.educationImg1,
    required this.educationImg2,
    required this.houseVerified,
    required this.houseImgs,
    required this.carVerified,
    required this.carImgs,
    required this.workVerified,
    required this.workImg1,
    required this.marriageVerified,
    required this.marriageImg1,
    required this.idcardRemark,
    required this.educationRemark,
    required this.workRemark,
    required this.marriageRemark,
    required this.houseRemark,
    required this.carRemark,
    required this.editNameTime,
    required this.school,
    required this.education,
    required this.mobile,
    required this.gender,
    required this.headImgVerified,
    required this.headImg,
  });

  factory Verified.fromJson(Map<String, dynamic> json) => Verified(
    id: asT<int>(json['id'])!,
    customerId: asT<int>(json['customer_id'])!,
    verifyUserId: asT<int>(json['verify_user_id'])!,
    verifyUserName: asT<String>(json['verify_user_name'])!,
    nameVerified: asT<int>(json['name_verified'])!,
    name: asT<String>(json['name'])!,
    idcardVerified: asT<int>(json['idcard_verified'])!,
    idcard: asT<String>(json['idcard'])!,
    idcardFront: asT<String>(json['idcard_front'])!,
    idcardBack: asT<String>(json['idcard_back'])!,
    educationVerified: asT<int>(json['education_verified'])!,
    educationImg1: asT<String>(json['education_img_1'])!,
    educationImg2: asT<String>(json['education_img_2'])!,
    houseVerified: asT<int>(json['house_verified'])!,
    houseImgs: asT<String>(json['house_imgs'])!,
    carVerified: asT<int>(json['car_verified'])!,
    carImgs: asT<String>(json['car_imgs'])!,
    workVerified: asT<int>(json['work_verified'])!,
    workImg1: asT<String>(json['work_img_1'])!,
    marriageVerified: asT<int>(json['marriage_verified'])!,
    marriageImg1: asT<String>(json['marriage_img_1'])!,
    idcardRemark: asT<String>(json['idcard_remark'])!,
    educationRemark: asT<String>(json['education_remark'])!,
    workRemark: asT<String>(json['work_remark'])!,
    marriageRemark: asT<String>(json['marriage_remark'])!,
    houseRemark: asT<String>(json['house_remark'])!,
    carRemark: asT<String>(json['car_remark'])!,
    editNameTime: asT<int>(json['edit_name_time'])!,
    school: asT<String>(json['school'])!,
    education: asT<int>(json['education'])!,
    mobile: asT<String>(json['mobile'])!,
    gender: asT<int>(json['gender'])!,
    headImgVerified: asT<int>(json['head_img_verified'])!,
    headImg: asT<String>(json['head_img'])!,
  );

  int id;
  int customerId;
  int verifyUserId;
  String verifyUserName;
  int nameVerified;
  String name;
  int idcardVerified;
  String idcard;
  String idcardFront;
  String idcardBack;
  int educationVerified;
  String educationImg1;
  String educationImg2;
  int houseVerified;
  String houseImgs;
  int carVerified;
  String carImgs;
  int workVerified;
  String workImg1;
  int marriageVerified;
  String marriageImg1;
  String idcardRemark;
  String educationRemark;
  String workRemark;
  String marriageRemark;
  String houseRemark;
  String carRemark;
  int editNameTime;
  String school;
  int education;
  String mobile;
  int gender;
  int headImgVerified;
  String headImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'customer_id': customerId,
    'verify_user_id': verifyUserId,
    'verify_user_name': verifyUserName,
    'name_verified': nameVerified,
    'name': name,
    'idcard_verified': idcardVerified,
    'idcard': idcard,
    'idcard_front': idcardFront,
    'idcard_back': idcardBack,
    'education_verified': educationVerified,
    'education_img_1': educationImg1,
    'education_img_2': educationImg2,
    'house_verified': houseVerified,
    'house_imgs': houseImgs,
    'car_verified': carVerified,
    'car_imgs': carImgs,
    'work_verified': workVerified,
    'work_img_1': workImg1,
    'marriage_verified': marriageVerified,
    'marriage_img_1': marriageImg1,
    'idcard_remark': idcardRemark,
    'education_remark': educationRemark,
    'work_remark': workRemark,
    'marriage_remark': marriageRemark,
    'house_remark': houseRemark,
    'car_remark': carRemark,
    'edit_name_time': editNameTime,
    'school': school,
    'education': education,
    'mobile': mobile,
    'gender': gender,
    'head_img_verified': headImgVerified,
    'head_img': headImg,
  };
}
