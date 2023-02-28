import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ckt/pages/flow_page/logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/entities/loan/note.dart';
import '../logic.dart';
const String defaultImg =
    'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
final _random = Random();
int next(int min, int max) => min + _random.nextInt(max - min);

class MySms extends StatelessWidget {
  final List<NoteDataData> liveData;

  MySms({required this.liveData});
  final logic = Get.find<SmsPageLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      color: Colors.transparent,
      child: Column(children: <Widget>[
        //_listTableHeader(),
        _listTableInfo(context, liveData),
      ]),
    );
  }

  String getExt(String name) {
    var m = "";
    var d = name.split(".");
    for (int i = 0; i < d.length; i++) {
      m = d[i];
    }
    return m;
  }

  Widget _listTableInfo(context, List<NoteDataData> liveData) {
    final liveList = <Widget>[];
    liveData.asMap().keys.forEach((index) {
      NoteDataData item = liveData[index];
      liveList.add(
        Container(
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(14.w),
              )),
          key: ObjectKey(item.id),
          padding:
              EdgeInsets.only(left: 40.w, right: 40.w,top: 20.h, bottom: 0.h),
          margin: EdgeInsets.only(left: 60.w,right: 60.w,bottom: 10.h),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 65.h,
                                child: Text(item.title,style: TextStyle(fontSize: 34.sp,fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 120.h,
                                child: Text(item.content),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 65.h,
                                child: Text(item.dateTime,style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.normal,color: Colors.black54)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });

    return Wrap(
      children: liveList,
    );
  }


}
