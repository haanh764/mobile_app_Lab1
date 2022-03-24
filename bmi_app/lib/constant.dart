import 'package:flutter/material.dart';

// Assets
// const assetBmiChartImage = 'assets/images/bmi-chart.png';

// Colors
// const primaryColor = Color(0xFFCA4F5D);
const normalBmiColor = Color.fromARGB(255, 139, 201, 141);
const underweightBmiColor = Color.fromARGB(255, 170, 199, 226);
const overweightBmiColor = Color.fromARGB(255, 255, 174, 0);
const obese1BmiColor = Color.fromARGB(255, 255, 136, 0);
const obese2BmiColor = Color.fromARGB(255, 255, 94, 0);
const obese3BmiColor = Color.fromARGB(255, 139, 0, 0);

// const activeButtonBgColor = Colors.white;
// const activeButtonTextColor = Color(0xFFCA4F5D);
// final inactiveButtonBgColor = const Color(0xFFF6CFD5).withOpacity(.5);
// final inactiveButtonTextColor = Colors.white.withOpacity(.7);
// const containerGradientColors = <Color>[Color(0xFFEA6B5D), Color(0xFFE95263)];

// Decorations
// final actionButtonDecoration = BoxDecoration(
//   shape: BoxShape.circle,
//   boxShadow: [
//     BoxShadow(
//       color: primaryColor.withOpacity(.4),
//       blurRadius: 6,
//       offset: const Offset(0, 2),
//     ),
//   ],
// );

// const mainContainerDecoration = BoxDecoration(
//   boxShadow: [
//     BoxShadow(blurRadius: .5, color: primaryColor),
//   ],
//   gradient: LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: containerGradientColors,
//   ),
// );

// Text Styles
// const appBarTextStyle = TextStyle(
//   color: Color(0xFFCA4F5D),
//   fontSize: 22,
//   fontWeight: FontWeight.w900,
// );


//Messages
const messUnderweight = "You are underweight";
const messNormal = "You are normal";
const messOverWeight = "You are overweight";
const messObeseType1 = "You are obese class I";
const messObeseType2 = "You are obese class II";
const messObeseType3 = "You are obese class III";


  
enum UnitType{
  KilogamMetter, FeetPound
}