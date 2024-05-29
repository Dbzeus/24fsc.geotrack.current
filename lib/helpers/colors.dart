import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

const primaryColor = Color.fromRGBO(58, 174, 31, 1);
const secondaryColor = Color.fromRGBO(9, 70, 187, 1);

const lightBgGreenColor = Color.fromRGBO(213, 255, 203, 1);

const blackColor =  Color.fromRGBO(0, 0, 0, 1);
const whiteColor = Color.fromRGBO(255, 255, 255, 1);

const fillColor = Color.fromRGBO(240, 240, 240, 1);
const borderColor = Color.fromRGBO(241, 241, 241, 1);
const dividerColor = Color.fromRGBO(177, 177, 177, 1);

const bgColor = Color.fromRGBO(255, 255, 255, 1);


const boxShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1), // rgba(0,0,0,0.1)
    offset: Offset(0, 11), // 0px 11px
    blurRadius: 24, // 24px
  )
];

const bgGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0,
      100
    ],
    colors: [
      Color.fromRGBO(213, 255, 203, 1),
      Color.fromRGBO(169, 255, 149, 1),
    ]);
