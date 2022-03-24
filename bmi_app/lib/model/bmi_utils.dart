import 'dart:math';
import 'package:flutter/rendering.dart';
import '../constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

String determineBMIMessage(double bmi) {
    if (bmi < 18.5) {
      return messUnderweight;
    } else if (bmi < 25) {
      return messNormal;
    } else if (bmi < 30) {
      return messOverWeight;
    } else if (bmi < 35) {
      return messObeseType1;
    } else if (bmi < 40) {
      return messObeseType2;
    } else {
      return messObeseType3;
    }
}

Color determineBMIMessageColor(double bmi) {
    if (bmi < 18.5) {
      return underweightBmiColor;
    } else if (bmi < 25) {
      return normalBmiColor;
    } else if (bmi < 30) {
      return overweightBmiColor;
    } else if (bmi < 35) {
      return obese1BmiColor;
    } else if (bmi < 40) {
      return obese2BmiColor;
    } else {
      return obese3BmiColor;
    }
}

double BMICalculator(double height, double weight, UnitType uniType) {
    if (height <= 0.0) return 0.0;
    double bmiValue = uniType == UnitType.KilogamMetter? (weight / pow(height/100, 2)) :
      (weight / pow(height, 2) * 703);
    return bmiValue;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }
}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}
