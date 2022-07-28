import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/entities/home/common.dart';

typedef BoolWidgetBuilder = Widget Function(BuildContext context, bool selected,String name);

class MultiChipFilters extends StatefulWidget {
  final List<SelectItem> data;
  final List<SelectItem> selectedS ;
  final BoolWidgetBuilder labelBuilder;
  final IndexedWidgetBuilder avatarBuilder;
  final Function(List<SelectItem>) onChange;
  final double childAspectRatio;
  MultiChipFilters({Key? key, required this.data,required this.labelBuilder,required this.avatarBuilder,required this.onChange,required this.selectedS,required this.childAspectRatio}) : super(key: key);

  @override
  _MultiChipFilterState createState() => _MultiChipFilterState();
}

class _MultiChipFilterState extends State<MultiChipFilters> {

  @override
  Widget build(BuildContext context) {
    widget.childAspectRatio;
    return Container(
      padding: EdgeInsets.only(left: 30.w,right: 20.w),
      alignment: Alignment.centerLeft,
      child: Wrap(
        runSpacing: 5.w,
        spacing: 20.w,
        // primary: false,
        // shrinkWrap: true,
        // crossAxisCount: 4,
        // mainAxisSpacing: 6.h,
        // crossAxisSpacing: 12.h,
        // childAspectRatio:widget.childAspectRatio,
        // padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 6.h),
//    padding: EdgeInsets.all(6),
        children: widget.data.map((e) =>
            _buildChild(context,widget.data.indexOf(e),e)).toList(),
      ),
    );
  }

  Widget _buildChild(BuildContext context,int index,SelectItem t) {
    bool selected = t.isSelect!;
    return ChoiceChip(
      backgroundColor: Colors.grey.withAlpha(33),
      selectedColor: Theme
          .of(context)
          .primaryColor,
      padding: EdgeInsets.only(left: 25.w,right: 25.w,top: 15.h,bottom: 15.h),
      labelPadding: EdgeInsets.only(left: 0.w,right: 0.w),
      selectedShadowColor: Colors.black,
      shadowColor: Colors.transparent,
      pressElevation: 5,
      elevation: 3,
      //avatar: widget.avatarBuilder(context,index),
      label: widget.labelBuilder(context,selected,t.name!),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            widget.selectedS.add(t);

          } else {

            widget.selectedS.removeWhere((i) => (i.id == t.id && i.type == t.type));
          }
          t.isSelect = value;
          widget.onChange(widget.selectedS);
        });
      },
    );
  }
}