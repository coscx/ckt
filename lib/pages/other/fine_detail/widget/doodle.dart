import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';

class Doodle {
  final String name;
  final String commitUser;
  final String auditUser;
  final String bankAddress;
  final String bankManager;
  final String auditResult;
  final String loanResult;
  final String operateUser;
  final String thisLoanTime;
  final String thisLoanAmount;
  final String lendingLoanAmount;
  final String auditTime;
  final String operateTime;
  final String commitTime;
  final String receiveTime;
  final Color iconBackground;
  final Icon icon;
  final Color color;
  final double opacity;
  final String flag;
  final int current;
  final List<Pic>? pics;

  const Doodle({
    required this.name,
    required this.commitUser,
    required this.auditUser,
    required this.bankAddress,
    required this.bankManager,
    required this.auditResult,
    required this.loanResult,
    required this.operateUser,
    required this.thisLoanTime,
    required this.thisLoanAmount,
    required this.lendingLoanAmount,
    required this.auditTime,
    required this.operateTime,
    required this.commitTime,
    required this.receiveTime,
    required this.icon,
    required this.iconBackground,
    required this.color,
    required this.opacity,
    required this.flag,
    required this.current,
    required this.pics,
  });
}
