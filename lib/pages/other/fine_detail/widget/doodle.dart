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
