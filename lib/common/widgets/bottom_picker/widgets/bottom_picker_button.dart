import '../resources/arrays.dart';
import 'package:flutter/material.dart';

class BottomPickerButton extends StatelessWidget {
  final Function onClick;
  final List<Color> gradientColors;
  final Color iconColor;
  final String? text;
  final bool displayIcon;
  final TextStyle? textStyle;
  final Color? solidColor;

  BottomPickerButton({
    Key? key,
    required this.onClick,
    required this.iconColor,
    this.text,
    this.textStyle,
    this.displayIcon = true,
    this.gradientColors = blueThemeColor,
    this.solidColor,
  }) : super(key: key) {
    if (!displayIcon) {
      assert(text != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: solidColor,
          gradient: solidColor == null
              ? LinearGradient(
                  colors: gradientColors,
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 150,right: 150),
          child: Row(
            children: [
              if (text != null) Text(text!, style: textStyle),
              if (displayIcon)
                Icon(
                  Icons.done,
                  color: iconColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
