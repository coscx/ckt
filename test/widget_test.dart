// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ckt/main.dart';

void main() {


  test("Counter Class test", () {
    var json = {
      "code": 23,
      "msg": "588",
      "data": [
        {
          "posId": 1018,
          "initPos": 0,
          "posInterval": 0,
          "sourceCode": [
            {
              "code": "250",
              "impressionInterval": "60",
              "misRate": 0,
              "misCount": 0,
              "viewCount": 0,
              "adnId": 100
            }
          ]
        }
      ]
    };
    var json1 = {
      "code": 0,
      "msg": "hello",
      "data": "null"
    };
   var  object = Root.fromJson(json);
   print(object);
    //expect(counter, 1);
  });

}
