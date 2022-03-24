import 'package:flutter/rendering.dart';
import 'bmi_utils.dart';
import '../constant.dart';

class BMIViewModel {
  double _bmi = 0.0;
  UnitType _unitType = UnitType.FeetPound;

  late double height;
  late double weight;

  double get bmi => _bmi;
  set bmi(double outBMI){
    _bmi = outBMI;
  }

  UnitType get unitType => _unitType;
  set unitType(UnitType setValue){
    _unitType = setValue;
  }

  int get value => _unitType == UnitType.KilogamMetter?0 : 1;
  set value(int value){
    _unitType = value == 0? UnitType.KilogamMetter: UnitType.FeetPound;
  }

  String get heightMessage => _unitType == UnitType.KilogamMetter? "Height in cm" : "Height in inch";
  String get weightMessage => _unitType == UnitType.KilogamMetter? "Weight in kg" : "Weight in pound";
  String get bmiMessage => determineBMIMessage(_bmi);
  Color get bmiMessageColor => determineBMIMessageColor(_bmi);
  String get bmiInString => bmi.toStringAsFixed(2);
  String get heightInString => height != null ? height.toString():'';
  String get weightInString => weight != null ? weight.toString():'';

  BMIViewModel();
}
