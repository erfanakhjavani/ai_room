import 'package:flutter/material.dart';

const kPurpleColor = Color(0xFF6C63FF);
const kRedColor = Color(0xFFFF2D55);
const kGreenColor = Color(0xFF00C857);

TextStyle textSmall ({Color? color}){
  return  TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: 12
  );}

TextStyle textMedium ({Color? color}){
  return  TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: 16
  );}

TextStyle textLarge ({Color? color}){
  return  TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 18
  );}

TextStyle textBig ({Color? color}){
   return  TextStyle(
        color: color,
       fontWeight: FontWeight.w500,
   fontSize: 20
);}