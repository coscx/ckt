import 'package:flutter/cupertino.dart';

class ExpansionPanelItem {
  final String? headerText;
  final Widget? body;
  bool? isExpanded;

  ExpansionPanelItem({ this.headerText,  this.body,  this.isExpanded});
}

class SelectItem {
  String? name;
  String? id;
  bool? isSelect;
  int? type;
  int? num;
  SelectItem({ this.name,  this.id,  this.isSelect,  this.type,this.num});
}

class StoreItem {
  String? name;
  int? id;
  String? price;
  String? month;
  String? count;
  String? tag;
  bool? isSelect;
  int? index;
  int? type;

  StoreItem(
      {this.name,
        this.id,
        this.isSelect,
        this.index,
        this.type,
        this.price,
        this.month,
        this.count,
        this.tag});
}

class UserItem {
  String? name;
  String? id;
  bool? isSelect;
  int? index;
  int? type;

  UserItem({ this.name,  this.id,  this.isSelect,  this.index,  this.type});
}

class SortCondition {
  String? name;
  bool? isSelected;
  int? id;
  bool? all;

  SortCondition({this.name, this.id, this.isSelected, this.all}) {}
}

class StoreSelect {
  String? name;
  int? id;
  bool? isSelected;
  int? city;

  StoreSelect({this.name, this.id, this.city, this.isSelected});
}

class CitySelect {
  String? name;
  int? id;
  bool? isSelected;

  CitySelect({this.name, this.id, this.isSelected});
}