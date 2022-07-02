import 'package:flutter/material.dart';
enum Gender {
  unDefined,
  male,
  female,
}

enum ActivityLevel {
  unDefined,
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extremlyActive,
}

enum Goal {
  unDefined,
  looseWeight,
  maintainWeight,
  gainWeight,
}

Gender selectedGender = Gender.male;

bool isThemeDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}