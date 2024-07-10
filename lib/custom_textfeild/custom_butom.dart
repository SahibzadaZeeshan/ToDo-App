import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final FontWeight? fontBold;
  final double? fontSize;
  final double? height;
  final double? borderRadius;
  final double? width;
  final Color? textColor;

  final Color? backgroundColor;
  final VoidCallback? onPress;

  const CustomButton(
      {super.key,
      this.text = "",
      this.fontBold = FontWeight.w500,
      this.fontSize = 15,
      this.height = 58,
      this.borderRadius = 20,
      this.width = double.infinity,
      this.backgroundColor = Colors.blue,
      this.onPress,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),
                color: backgroundColor),
            child: Center(
                child: Text(
              text!,
              style: TextStyle(color: textColor,fontWeight: fontBold,fontSize: fontSize,),
            ))),
        onTap: onPress,
      ),
    );
  }
}
