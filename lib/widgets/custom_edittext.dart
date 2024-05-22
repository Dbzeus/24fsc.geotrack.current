

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geotrack24fsc/helpers/colors.dart';


class CustomEditText extends StatelessWidget {


  String hintText;
  Widget? suffixIcon, prefixIcon;
  bool obscureText,isBorder,showCursor,readOnly;
  double? borderRadius;
  TextInputType? keyboardType;
  int? maxLength, maxLines, minLines;
  Function(String)? onChanged;
  TextAlign? textAlign;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;

   CustomEditText({
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIcon,
     this.isBorder=false,
     this.showCursor=true,
     this.readOnly=false,
    this.prefixIcon,
     this.textAlign,
    this.obscureText = false,
    this.borderRadius,
    this.keyboardType,
    this.onChanged,
     this.inputFormatters,
    super.key});




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: blackColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: TextFormField(
            onChanged: onChanged,
            maxLines: maxLines,
            minLines: minLines,
            showCursor: showCursor,
            textAlign:  textAlign ?? TextAlign.start,
            keyboardType: keyboardType,
            maxLength: maxLength,
            obscureText: obscureText,
            obscuringCharacter: "●",
            readOnly: readOnly,
            controller: controller,
            style:  const TextStyle(fontSize: 16,color: blackColor),
            cursorHeight: 28,
            inputFormatters: inputFormatters ?? [],
            decoration:  InputDecoration(
              isDense: true,
              hintText: "",
              hintStyle: const TextStyle(fontSize: 14,color:  Colors.grey),
              fillColor:   fillColor,
              filled: true,
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),


              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              counter: null,
              counterText: '',
              focusColor: Colors.black,

            ),

          ),
        ),
      ],
    );
  }
}
