import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/bottom_picker/bottom_picker.dart';
import '../../../../common/widgets/bottom_picker/resources/arrays.dart';

class BottomPickers extends StatelessWidget {
  const BottomPickers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          BottomPicker.date(
              initialDateTime: DateTime(1990,6,1),
              height: 600.h,
              buttonTextStyle: TextStyle(color: Colors.white,fontSize: 32.sp),
              buttonSingleColor: Colors.green,
              displayButtonIcon: false,
              buttonText: "确定",
              title:  "选择日期",
              titleStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize:  38.sp,
                  color: Colors.black
              ),
              onChange: (index) {
                print(index);
              },
              onSubmit: (index) {
                print(index);
              },
              bottomPickerTheme: BottomPickerTheme.plumPlate
          ).show(context);
        },
        child: Text("123")
    );
  }
}
