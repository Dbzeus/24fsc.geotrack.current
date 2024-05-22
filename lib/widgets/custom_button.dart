import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/colors.dart';

class CustomButton extends StatelessWidget {
  double? height, width;
  double borderRadius, fontSize;
  FontWeight? fontWeight;
  Color textColor;
  Color btnColor;
  String text;
  Function()? onTap;
  IconData? icon;
  bool isIcon;
  EdgeInsets? margin;
  Border? border;

  CustomButton({
    Key? key,
    this.width,
    this.fontWeight,
    this.height = 50,
    this.margin,
    this.borderRadius = 30,
    this.border,
    this.fontSize = 14,
    this.btnColor = primaryColor,
    this.textColor = Colors.white,
    this.isIcon = false,
    required this.text,
    this.icon  ,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )
        ),
        onPressed: onTap,
        child: Center(
          child:  isIcon ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              Icon(icon,
              color: textColor,
                size: fontSize+4,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                text,
                style: TextStyle(
                    color: textColor, fontSize: fontSize,fontWeight: fontWeight),
              ),
            ],
          ) :  Text(
            text,
            maxLines: 1,
            style: TextStyle(color: textColor, fontSize: fontSize,fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
