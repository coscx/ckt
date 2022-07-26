import 'package:flutter/cupertino.dart';
import 'package:flutter_ckt/common/widgets/date_picker/src/models/date_picker_scroll_view_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../date_picker/src/models/date_picker_options.dart';
import '../../date_picker/src/scroll_date_picker.dart';

class DatePicker extends StatelessWidget {
  final CupertinoDatePickerMode mode;
  final Function(DateTime) onDateChanged;
  final DateTime? initialDateTime;
  final DateTime? maxDateTime;
  final DateTime? minDateTime;
  final int minuteInterval;
  final bool use24hFormat;
  final DatePickerDateOrder? dateOrder;
  final TextStyle textStyle;

  const DatePicker({
    Key? key,
    required this.initialDateTime,
    this.minuteInterval = 1,
    required this.maxDateTime,
    required this.minDateTime,
    required this.mode,
    required this.onDateChanged,
    required this.use24hFormat,
    required this.textStyle,
    this.dateOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ScrollDatePicker(
        scrollViewOptions: DatePickerScrollViewOptions(year: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 38.sp,fontWeight: FontWeight.w500),alignment: Alignment.center),
            month: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 38.sp,fontWeight: FontWeight.w500),alignment: Alignment.center),
           day: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 38.sp,fontWeight: FontWeight.w500),alignment: Alignment.center)
        ),
        options: DatePickerOptions(itemExtent: 90.h,diameterRatio: 5,perspective: 0.003,isLoop: false),
        selectedDate: initialDateTime ?? DateTime.now(),
        locale: Locale('ko'),
        onDateTimeChanged: (DateTime value) {
          onDateChanged(value);
        },
      ),
    );
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: textStyle,
        ),
      ),
      child: CupertinoDatePicker(
        mode: mode,
        onDateTimeChanged: onDateChanged,
        initialDateTime: initialDateTime,
        minuteInterval: minuteInterval,
        maximumDate: maxDateTime,
        minimumDate: minDateTime,
        use24hFormat: use24hFormat,
        dateOrder: dateOrder,
      ),
    );
  }
}

// class DatePicker extends StatefulWidget {
//   final CupertinoDatePickerMode mode;
//   final Function(DateTime) onDateChanged;
//   final DateTime? initialDateTime;
//   final DateTime? maxDateTime;
//   final DateTime? minDateTime;
//   final int minuteInterval;
//   final bool use24hFormat;
//   final DatePickerDateOrder? dateOrder;
//   final TextStyle textStyle;
//
//   const DatePicker({
//     Key? key,
//     required this.initialDateTime,
//     this.minuteInterval = 1,
//     required this.maxDateTime,
//     required this.minDateTime,
//     required this.mode,
//     required this.onDateChanged,
//     required this.use24hFormat,
//     required this.textStyle,
//     this.dateOrder,
//   }) : super(key: key);
//
//   @override
//   State<DatePicker> createState() => _DatePickerState();
// }
//
// class _DatePickerState extends State<DatePicker> {
//   DateTime t = DateTime.now();
//   @override
//   void initState() {
//     super.initState();
//     t= widget.initialDateTime ?? DateTime.now();
//   }
//   @override
//   Widget build(BuildContext context) {
//         return SizedBox(
//       child: ScrollDatePicker(
//         scrollViewOptions: DatePickerScrollViewOptions(year: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 24),alignment: Alignment.center),
//             month: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 24),alignment: Alignment.center),
//            day: ScrollViewDetailOptions(selectedTextStyle: TextStyle(fontSize: 24),alignment: Alignment.center)
//         ),
//         options: DatePickerOptions(itemExtent: 50,diameterRatio: 5,perspective: 0.01,isLoop: false),
//         selectedDate: t,
//         locale: Locale('ko'),
//         onDateTimeChanged: (DateTime value) {
//           widget.onDateChanged(value);
//           setState((){
//             t= value;
//           });
//         },
//       ),
//     );
//   }
// }

