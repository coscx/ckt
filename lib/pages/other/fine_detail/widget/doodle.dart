import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';

class Doodle {
  final String name;
  final String time;
  final String address;
  final String status;
  final String content;
  final String opUser;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  final Color color;
  final double opacity;
  final String flag;
  final int current;
  final List<Pic>? pics;
  const Doodle(
      {required this.name,
        required this.time,
        required this.content,
        required this.opUser,
        required this.address,
        required this.status,
        required this.doodle,
        required this.icon,
        required this.iconBackground,
        required this.color,
        required this.opacity,
        required this.flag,
        required this.current,
        required this.pics,
      });
}

// const List<Doodle> doodles = [
//   Doodle(
//       current:0 ,
//       flag: "",
//       opacity: 1,
//       color: Colors.white,
//       name: "Al-Sufi (Azophi)",
//       time: "903 - 986",
//       content: "操作人-张玲",
//       opUser: "操作人-张玲",
//       address: "",
//       status: "",
//       doodle:
//           "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4016383514,3614601022&fm=26&gp=0.jpg",
//       icon: Icon(Icons.star, color: Colors.white),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:0 ,
//       flag: "",
//       name: "Abu al-Wafa’ al-Buzjani",
//       time: "940 - 998",
//       content: "操作人-张玲",
//
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3789620214,3216522198&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.exposure,
//         color: Colors.white,
//       ),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:0 ,
//       flag: "",
//       name: "Al-Hasan Ibn al-Haytham",
//       time: "c. 965 - c. 1040",
//       content: "操作人-张玲",
//
//
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2536545892,2258796484&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.visibility,
//         color: Colors.black87,
//         size: 32.0,
//       ),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:0 ,
//       flag: "",
//       name: "Al-Bīrūnī",
//       time: "973 - 1050",
//       content: "操作人-张玲",
//
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2942458885,2161231393&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.account_balance,
//         color: Colors.black87,
//       ),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:0 ,
//       flag: "",
//       name: "Ibn Sina (Avicenna)",
//       time: "980 - 1037",
//       content: "操作人-张玲",
//
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2844749082,2312759693&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.healing,
//         color: Colors.white,
//       ),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:0 ,
//       flag: "",
//       name: "Ibn Rushd (Averroes)",
//       time: "1126 - 1198",
//       content: "操作人-张玲",
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3213237648,2312067813&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.blur_circular,
//         color: Colors.white,
//       ),
//       iconBackground: Colors.grey),
//   Doodle(color: Colors.white,
//       opacity: 1,
//
//       current:1 ,
//       flag: "",
//       name: "Nasir al-Din Tusi",
//       time: "1201 - 1274",
//       content: "操作人-张玲",
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1817632637,3443052285&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.category,
//         color: Colors.white,
//       ),
//       iconBackground: Colors.pinkAccent),
//   Doodle(color: Colors.white,
//
//       current:0 ,
//       flag: "assets/images/default/finish.png",
//       opacity: 1,
//       name: "Ibn Battuta",
//       time: "1304 - 1368",
//       content: "操作人-张玲",
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=357307289,3261904920&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.navigation,
//         color: Colors.white,
//         size: 32.0,
//       ),
//       iconBackground: Colors.deepPurpleAccent),
//   Doodle(color: Colors.white,
//
//       current:0 ,
//       flag: "assets/images/default/finish.png",
//       opacity: 1,
//       name: "Ibn Khaldun",
//       time: "1332 - 1406",
//       content: "操作人-张玲",
//       opUser: "操作人-张玲",
//
//       address: "",
//       status: "",
//
//       doodle:
//           "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4196133035,4167956900&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.supervised_user_circle,
//         color: Colors.white,
//       ),
//       iconBackground: Colors.teal),
//   Doodle(color: Colors.white,
//
//       current:0 ,
//       flag: "assets/images/default/finish.png",
//       opacity: 1,
//       name: "联系客户-待联系",
//       time: "操作时间:2022-06-06",
//       content: "备注:征信不行",
//       opUser: "",
//
//       address: "",
//       status: "是否办理:资质不符",
//
//       doodle: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1843767238,1936795003&fm=26&gp=0.jpg",
//       icon: Icon(
//         Icons.map,
//         color: Colors.white,
//         size: 32.0,
//       ),
//       iconBackground: Colors.blue),
// ];
