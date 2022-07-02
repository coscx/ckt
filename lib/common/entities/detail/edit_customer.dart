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

class EditCustomerDataResult {
  EditCustomerDataResult({
    required this.status,
    required this.code,
    required this.data,
  });

  factory EditCustomerDataResult.fromJson(Map<String, dynamic> json) =>
      EditCustomerDataResult(
        status: asT<String>(json['status'])!,
        code: asT<int>(json['code'])!,
        data:
        EditCustomerData.fromJson(asT<Map<String, dynamic>>(json['data'])!),
      );

  String status;
  int code;
  EditCustomerData data;

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

class EditCustomerData {
  EditCustomerData({
    required this.Info,
    required this.demand,
    required this.pic,
    required this.pics,
    required this.video,
    required this.pay,
    required this.black,
    required this.recommend,
    required this.verified,
    required this.canEdit,
    required this.progress,
    required this.canViewCall,
    required this.label,
    required this.mobile,
    required this.roleId,
  });

  factory EditCustomerData.fromJson(Map<String, dynamic> json) {
    final List<Object>? pic = json['pic'] is List ? <Object>[] : null;
    if (pic != null) {
      for (final dynamic item in json['pic']!) {
        if (item != null) {
          tryCatch(() {
            pic.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? pics = json['pics'] is List ? <Object>[] : null;
    if (pics != null) {
      for (final dynamic item in json['pics']!) {
        if (item != null) {
          tryCatch(() {
            pics.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<Object>? video = json['video'] is List ? <Object>[] : null;
    if (video != null) {
      for (final dynamic item in json['video']!) {
        if (item != null) {
          tryCatch(() {
            video.add(asT<Object>(item)!);
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
    return EditCustomerData(
      Info: EditCustomerInfo.fromJson(asT<Map<String, dynamic>>(json['info'])!),
      demand: Demand.fromJson(asT<Map<String, dynamic>>(json['demand'])!),
      pic: pic!,
      pics: pics!,
      video: video!,
      pay: pay!,
      black: Black.fromJson(asT<Map<String, dynamic>>(json['black'])!),
      recommend: asT<String>(json['recommend'])!,
      verified: Verified.fromJson(asT<Map<String, dynamic>>(json['verified'])!),
      canEdit: asT<int>(json['can_edit'])!,
      progress: asT<double>(json['progress'])!,
      canViewCall: asT<int>(json['can_view_call'])!,
      label: label!,
      mobile: asT<String>(json['mobile'])!,
      roleId: asT<int>(json['role_id'])!,
    );
  }

  EditCustomerInfo Info;
  Demand demand;
  List<Object> pic;
  List<Object> pics;
  List<Object> video;
  List<Object> pay;
  Black black;
  String recommend;
  Verified verified;
  int canEdit;
  double progress;
  int canViewCall;
  List<Object> label;
  String mobile;
  int roleId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'info': Info,
    'demand': demand,
    'pic': pic,
    'pics': pics,
    'video': video,
    'pay': pay,
    'black': black,
    'recommend': recommend,
    'verified': verified,
    'can_edit': canEdit,
    'progress': progress,
    'can_view_call': canViewCall,
    'label': label,
    'mobile': mobile,
    'role_id': roleId,
  };
}

class EditCustomerInfo {
  EditCustomerInfo({
    required this.id,
    required this.uuid,
    required this.code,
    required this.name,
    required this.gender,
    required this.mobile,
    required this.age,
    required this.status,
    required this.openid,
    required this.avatar,
    required this.headImg,
    required this.nickname,
    required this.vipName,
    required this.connectStatus,
    required this.connectCount,
    required this.channel,
    required this.spreadId,
    required this.spreadType,
    required this.appointmentCount,
    this.vipExpireTime,
    required this.createdAt,
    required this.saleUser,
    required this.serveUser,
    required this.serveId,
    required this.userId,
    required this.lastActiveTime,
    required this.isPassive,
    required this.isFreeze,
    required this.stop,
    required this.storeId,
    required this.single,
    required this.personal,
    required this.register,
    required this.singleConnect,
    required this.personalConnect,
    required this.registerConnect,
    required this.signServer,
    required this.hasSingle,
    required this.hasPersonal,
    required this.hasRegister,
    required this.smallId,
    required this.vipId,
    required this.selectUser,
    required this.selectService,
    required this.selectStore,
    required this.fireName,
    required this.appVipId,
    required this.createId,
    required this.height,
    required this.weight,
    required this.birthday,
    required this.bloodType,
    required this.nation,
    required this.chineseZodiac,
    required this.zodiac,
    required this.bazi,
    required this.wuxing,
    required this.npProvinceCode,
    required this.npCityCode,
    required this.npAreaCode,
    required this.lpProvinceCode,
    required this.lpCityCode,
    required this.lpAreaCode,
    required this.lpProvinceName,
    required this.lpCityName,
    required this.lpAreaName,
    required this.householdPlace,
    required this.nativePlace,
    required this.locationPlace,
    required this.marriage,
    required this.hasChild,
    required this.childRemark,
    required this.onlyChild,
    required this.parents,
    required this.fatherWork,
    required this.motherWork,
    required this.parentsIncome,
    required this.parentsInsurance,
    required this.education,
    required this.school,
    required this.major,
    required this.work,
    required this.workIndustry,
    required this.workJob,
    required this.workOvertime,
    required this.income,
    required this.hasHouse,
    required this.loanRecord,
    required this.hasCar,
    required this.carType,
    required this.carRecord,
    required this.faith,
    required this.smoke,
    required this.drinkwine,
    required this.liveRest,
    required this.wantChild,
    required this.marryTime,
    required this.interest,
    required this.demands,
    required this.cooking,
    required this.household,
    required this.liveWithParents,
    required this.remark,
    required this.tags,
    required this.intro,
    required this.sport,
    required this.food,
    required this.like,
    required this.friend,
    required this.partner,
    required this.free,
    required this.selectUserName,
    required this.selectServiceName,
    required this.appStoreName,
    required this.createName,
    required this.lastVipId,
    required this.smllLoginTime,
    required this.smllLastLoginTime,
    required this.vipSaleTime,
    required this.vipSaleMoney,
    this.qiyu,
  });

  factory EditCustomerInfo.fromJson(Map<String, dynamic> json) {
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
    return EditCustomerInfo(
      id: asT<int>(json['id'])!,
      uuid: asT<String>(json['uuid'])!,
      code: asT<int>(json['code'])!,
      name: asT<String>(json['name'])!,
      gender: asT<int>(json['gender'])!,
      mobile: asT<String>(json['mobile'])!,
      age: asT<int>(json['age'])!,
      status: asT<int>(json['status'])!,
      openid: asT<String>(json['openid'])!,
      avatar: asT<String>(json['avatar'])!,
      headImg: asT<String>(json['head_img'])!,
      nickname: asT<String>(json['nickname'])!,
      vipName: asT<String>(json['vip_name'])!,
      connectStatus: asT<int>(json['connect_status'])!,
      connectCount: asT<int>(json['connect_count'])!,
      channel: asT<int>(json['channel'])!,
      spreadId: asT<int>(json['spread_id'])!,
      spreadType: asT<int>(json['spread_type'])!,
      appointmentCount: asT<int>(json['appointment_count'])!,
      vipExpireTime: asT<Object?>(json['vip_expire_time']),
      createdAt: asT<String>(json['created_at'])!,
      saleUser: asT<String>(json['sale_user'])!,
      serveUser: asT<String>(json['serve_user'])!,
      serveId: asT<int>(json['serve_id'])!,
      userId: asT<int>(json['user_id'])!,
      lastActiveTime: asT<String>(json['last_active_time'])!,
      isPassive: asT<int>(json['is_passive'])!,
      isFreeze: asT<int>(json['is_freeze'])!,
      stop: asT<int>(json['stop'])!,
      storeId: asT<int>(json['store_id'])!,
      single: asT<String>(json['single'])!,
      personal: asT<String>(json['personal'])!,
      register: asT<String>(json['register'])!,
      singleConnect: asT<String>(json['single_connect'])!,
      personalConnect: asT<String>(json['personal_connect'])!,
      registerConnect: asT<String>(json['register_connect'])!,
      signServer: asT<String>(json['sign_server'])!,
      hasSingle: asT<int>(json['has_single'])!,
      hasPersonal: asT<int>(json['has_personal'])!,
      hasRegister: asT<int>(json['has_register'])!,
      smallId: asT<int>(json['small_id'])!,
      vipId: asT<int>(json['vip_id'])!,
      selectUser: asT<String>(json['select_user'])!,
      selectService: asT<String>(json['select_service'])!,
      selectStore: asT<String>(json['select_store'])!,
      fireName: asT<String>(json['fire_name'])!,
      appVipId: asT<int>(json['app_vip_id'])!,
      createId: asT<int>(json['create_id'])!,
      height: asT<int>(json['height'])!,
      weight: asT<int>(json['weight'])!,
      birthday: asT<String>(json['birthday'])!,
      bloodType: asT<int>(json['blood_type'])!,
      nation: asT<int>(json['nation'])!,
      chineseZodiac: asT<String>(json['chinese_zodiac'])!,
      zodiac: asT<String>(json['zodiac'])!,
      bazi: asT<String>(json['bazi'])!,
      wuxing: asT<String>(json['wuxing'])!,
      npProvinceCode: asT<String>(json['np_province_code'])!,
      npCityCode: asT<String>(json['np_city_code'])!,
      npAreaCode: asT<String>(json['np_area_code'])!,
      lpProvinceCode: asT<String>(json['lp_province_code'])!,
      lpCityCode: asT<String>(json['lp_city_code'])!,
      lpAreaCode: asT<String>(json['lp_area_code'])!,
      lpProvinceName: asT<String>(json['lp_province_name'])!,
      lpCityName: asT<String>(json['lp_city_name'])!,
      lpAreaName: asT<String>(json['lp_area_name'])!,
      householdPlace: asT<String>(json['household_place'])!,
      nativePlace: asT<String>(json['native_place'])!,
      locationPlace: asT<String>(json['location_place'])!,
      marriage: asT<int>(json['marriage'])!,
      hasChild: asT<int>(json['has_child'])!,
      childRemark: asT<String>(json['child_remark'])!,
      onlyChild: asT<int>(json['only_child'])!,
      parents: asT<int>(json['parents'])!,
      fatherWork: asT<String>(json['father_work'])!,
      motherWork: asT<String>(json['mother_work'])!,
      parentsIncome: asT<String>(json['parents_income'])!,
      parentsInsurance: asT<int>(json['parents_insurance'])!,
      education: asT<int>(json['education'])!,
      school: asT<String>(json['school'])!,
      major: asT<String>(json['major'])!,
      work: asT<int>(json['work'])!,
      workIndustry: asT<String>(json['work_industry'])!,
      workJob: asT<int>(json['work_job'])!,
      workOvertime: asT<int>(json['work_overtime'])!,
      income: asT<int>(json['income'])!,
      hasHouse: asT<int>(json['has_house'])!,
      loanRecord: asT<int>(json['loan_record'])!,
      hasCar: asT<int>(json['has_car'])!,
      carType: asT<int>(json['car_type'])!,
      carRecord: asT<int>(json['car_record'])!,
      faith: asT<int>(json['faith'])!,
      smoke: asT<int>(json['smoke'])!,
      drinkwine: asT<int>(json['drinkwine'])!,
      liveRest: asT<int>(json['live_rest'])!,
      wantChild: asT<int>(json['want_child'])!,
      marryTime: asT<int>(json['marry_time'])!,
      interest: asT<String>(json['interest'])!,
      demands: asT<String>(json['demands'])!,
      cooking: asT<int>(json['cooking'])!,
      household: asT<int>(json['household'])!,
      liveWithParents: asT<int>(json['live_with_parents'])!,
      remark: asT<String>(json['remark'])!,
      tags: tags!,
      intro: asT<String>(json['intro'])!,
      sport: asT<String>(json['sport'])!,
      food: asT<String>(json['food'])!,
      like: asT<String>(json['like'])!,
      friend: asT<String>(json['friend'])!,
      partner: asT<String>(json['partner'])!,
      free: asT<String>(json['free'])!,
      selectUserName: asT<String>(json['select_user_name'])!,
      selectServiceName: asT<String>(json['select_service_name'])!,
      appStoreName: asT<String>(json['app_store_name'])!,
      createName: asT<String>(json['create_name'])!,
      lastVipId: asT<int>(json['last_vip_id'])!,
      smllLoginTime: asT<String>(json['smll_login_time'])!,
      smllLastLoginTime: asT<String>(json['smll_last_login_time'])!,
      vipSaleTime: asT<String>(json['vip_sale_time'])!,
      vipSaleMoney: asT<int>(json['vip_sale_money'])!,
      qiyu: asT<Object?>(json['qiyu']),
    );
  }

  int id;
  String uuid;
  int code;
  String name;
  int gender;
  String mobile;
  int age;
  int status;
  String openid;
  String avatar;
  String headImg;
  String nickname;
  String vipName;
  int connectStatus;
  int connectCount;
  int channel;
  int spreadId;
  int spreadType;
  int appointmentCount;
  Object? vipExpireTime;
  String createdAt;
  String saleUser;
  String serveUser;
  int serveId;
  int userId;
  String lastActiveTime;
  int isPassive;
  int isFreeze;
  int stop;
  int storeId;
  String single;
  String personal;
  String register;
  String singleConnect;
  String personalConnect;
  String registerConnect;
  String signServer;
  int hasSingle;
  int hasPersonal;
  int hasRegister;
  int smallId;
  int vipId;
  String selectUser;
  String selectService;
  String selectStore;
  String fireName;
  int appVipId;
  int createId;
  int height;
  int weight;
  String birthday;
  int bloodType;
  int nation;
  String chineseZodiac;
  String zodiac;
  String bazi;
  String wuxing;
  String npProvinceCode;
  String npCityCode;
  String npAreaCode;
  String lpProvinceCode;
  String lpCityCode;
  String lpAreaCode;
  String lpProvinceName;
  String lpCityName;
  String lpAreaName;
  String householdPlace;
  String nativePlace;
  String locationPlace;
  int marriage;
  int hasChild;
  String childRemark;
  int onlyChild;
  int parents;
  String fatherWork;
  String motherWork;
  String parentsIncome;
  int parentsInsurance;
  int education;
  String school;
  String major;
  int work;
  String workIndustry;
  int workJob;
  int workOvertime;
  int income;
  int hasHouse;
  int loanRecord;
  int hasCar;
  int carType;
  int carRecord;
  int faith;
  int smoke;
  int drinkwine;
  int liveRest;
  int wantChild;
  int marryTime;
  String interest;
  String demands;
  int cooking;
  int household;
  int liveWithParents;
  String remark;
  List<Object> tags;
  String intro;
  String sport;
  String food;
  String like;
  String friend;
  String partner;
  String free;
  String selectUserName;
  String selectServiceName;
  String appStoreName;
  String createName;
  int lastVipId;
  String smllLoginTime;
  String smllLastLoginTime;
  String vipSaleTime;
  int vipSaleMoney;
  Object? qiyu;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uuid': uuid,
    'code': code,
    'name': name,
    'gender': gender,
    'mobile': mobile,
    'age': age,
    'status': status,
    'openid': openid,
    'avatar': avatar,
    'head_img': headImg,
    'nickname': nickname,
    'vip_name': vipName,
    'connect_status': connectStatus,
    'connect_count': connectCount,
    'channel': channel,
    'spread_id': spreadId,
    'spread_type': spreadType,
    'appointment_count': appointmentCount,
    'vip_expire_time': vipExpireTime,
    'created_at': createdAt,
    'sale_user': saleUser,
    'serve_user': serveUser,
    'serve_id': serveId,
    'user_id': userId,
    'last_active_time': lastActiveTime,
    'is_passive': isPassive,
    'is_freeze': isFreeze,
    'stop': stop,
    'store_id': storeId,
    'single': single,
    'personal': personal,
    'register': register,
    'single_connect': singleConnect,
    'personal_connect': personalConnect,
    'register_connect': registerConnect,
    'sign_server': signServer,
    'has_single': hasSingle,
    'has_personal': hasPersonal,
    'has_register': hasRegister,
    'small_id': smallId,
    'vip_id': vipId,
    'select_user': selectUser,
    'select_service': selectService,
    'select_store': selectStore,
    'fire_name': fireName,
    'app_vip_id': appVipId,
    'create_id': createId,
    'height': height,
    'weight': weight,
    'birthday': birthday,
    'blood_type': bloodType,
    'nation': nation,
    'chinese_zodiac': chineseZodiac,
    'zodiac': zodiac,
    'bazi': bazi,
    'wuxing': wuxing,
    'np_province_code': npProvinceCode,
    'np_city_code': npCityCode,
    'np_area_code': npAreaCode,
    'lp_province_code': lpProvinceCode,
    'lp_city_code': lpCityCode,
    'lp_area_code': lpAreaCode,
    'lp_province_name': lpProvinceName,
    'lp_city_name': lpCityName,
    'lp_area_name': lpAreaName,
    'household_place': householdPlace,
    'native_place': nativePlace,
    'location_place': locationPlace,
    'marriage': marriage,
    'has_child': hasChild,
    'child_remark': childRemark,
    'only_child': onlyChild,
    'parents': parents,
    'father_work': fatherWork,
    'mother_work': motherWork,
    'parents_income': parentsIncome,
    'parents_insurance': parentsInsurance,
    'education': education,
    'school': school,
    'major': major,
    'work': work,
    'work_industry': workIndustry,
    'work_job': workJob,
    'work_overtime': workOvertime,
    'income': income,
    'has_house': hasHouse,
    'loan_record': loanRecord,
    'has_car': hasCar,
    'car_type': carType,
    'car_record': carRecord,
    'faith': faith,
    'smoke': smoke,
    'drinkwine': drinkwine,
    'live_rest': liveRest,
    'want_child': wantChild,
    'marry_time': marryTime,
    'interest': interest,
    'demands': demands,
    'cooking': cooking,
    'household': household,
    'live_with_parents': liveWithParents,
    'remark': remark,
    'tags': tags,
    'intro': intro,
    'sport': sport,
    'food': food,
    'like': like,
    'friend': friend,
    'partner': partner,
    'free': free,
    'select_user_name': selectUserName,
    'select_service_name': selectServiceName,
    'app_store_name': appStoreName,
    'create_name': createName,
    'last_vip_id': lastVipId,
    'smll_login_time': smllLoginTime,
    'smll_last_login_time': smllLastLoginTime,
    'vip_sale_time': vipSaleTime,
    'vip_sale_money': vipSaleMoney,
    'qiyu': qiyu,
  };
}

class Demand {
  Demand({
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
    required this.wishBody,
    required this.description,
  });

  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
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
    wishBody: asT<String>(json['wish_body'])!,
    description: asT<String>(json['description'])!,
  );

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
  String wishBody;
  String description;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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
    'wish_body': wishBody,
    'description': description,
  };
}

class Black {
  Black({
    required this.isSystemBlack,
    required this.createTime,
    required this.expireDate,
    required this.remark,
  });

  factory Black.fromJson(Map<String, dynamic> json) => Black(
    isSystemBlack: asT<int>(json['is_system_black'])!,
    createTime: asT<String>(json['create_time'])!,
    expireDate: asT<String>(json['expire_date'])!,
    remark: asT<String>(json['remark'])!,
  );

  int isSystemBlack;
  String createTime;
  String expireDate;
  String remark;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'is_system_black': isSystemBlack,
    'create_time': createTime,
    'expire_date': expireDate,
    'remark': remark,
  };
}

class Verified {
  Verified({
    required this.idcardVerified,
    required this.educationVerified,
    required this.houseVerified,
    required this.carVerified,
    required this.workVerified,
    required this.marriageVerified,
  });

  factory Verified.fromJson(Map<String, dynamic> json) => Verified(
    idcardVerified: asT<int>(json['idcard_verified'])!,
    educationVerified: asT<int>(json['education_verified'])!,
    houseVerified: asT<int>(json['house_verified'])!,
    carVerified: asT<int>(json['car_verified'])!,
    workVerified: asT<int>(json['work_verified'])!,
    marriageVerified: asT<int>(json['marriage_verified'])!,
  );

  int idcardVerified;
  int educationVerified;
  int houseVerified;
  int carVerified;
  int workVerified;
  int marriageVerified;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'idcard_verified': idcardVerified,
    'education_verified': educationVerified,
    'house_verified': houseVerified,
    'car_verified': carVerified,
    'work_verified': workVerified,
    'marriage_verified': marriageVerified,
  };
}
