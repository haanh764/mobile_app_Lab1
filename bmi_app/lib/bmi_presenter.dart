import 'bmi_view.dart';
import 'model/bmi_view_model.dart';
import 'constant.dart';
import 'model/bmi_utils.dart';

class BMIPresenter {
  void onCalculateClicked(String weightString, String heightString){
  }
  void onOptionChanged(int value, {required String weightString, required String heightString}) {
  }
  set bmiView(BMIView value){}

  void onHeightSubmitted(String height){}
  void onWeightSubmitted(String weight){}
}

class BasicBMIPresenter implements BMIPresenter{
  late BMIViewModel _viewModel;
  late BMIView _view;
  
  BasicBMIPresenter() {
    this._viewModel = BMIViewModel();
    _loadUnit();
  }

  void _loadUnit() async{
    _viewModel.value = await loadValue();
    _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
  }

  @override
  set bmiView(BMIView value) {
    _view = value;
    _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
  }

  @override
  void onCalculateClicked(String weightString, String heightString) {
    var height = 0.0;
    var weight = 0.0;
    try {
      height = double.parse(heightString);
    } catch (e){

    }
    try {
      weight = double.parse(weightString);
    } catch (e) {
    }
    _viewModel.height = height;
    _viewModel.weight = weight;
    _viewModel.bmi = BMICalculator(height, weight, _viewModel.unitType);
    _view.updateBmiValue(_viewModel.bmiInString, _viewModel.bmiMessage, _viewModel.bmiMessageColor);
  }

  @override
  void onOptionChanged(int value, {required String weightString, required String heightString})  {
    final weightScale = 2.2046226218;
    final heightScale = 2.54;

    if (value != _viewModel.value) {
      _viewModel.value = value;
      saveValue(_viewModel.value);
      var height;
      var weight;
      if (!isEmptyString(heightString)) {
        try {
          height = double.parse(heightString);
        } catch (e) {
        }
      }
      if (!isEmptyString(weightString)) {
        try {
          weight = double.parse(weightString);
        } catch (e) {
        }
      }

      if (_viewModel.unitType == UnitType.FeetPound) {
        if (weight != null) _viewModel.weight =  weight * weightScale;
        if (height != null) _viewModel.height =  height / heightScale;
      } else {
        if (weight != null) _viewModel.weight =  weight / weightScale;
        if (height != null) _viewModel.height =  height * heightScale;
      }

      _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
      _view.updateHeight(height: _viewModel.heightInString);
      _view.updateWeight(weight: _viewModel.weightInString);
    }
  }

  @override
  void onHeightSubmitted(String height) {
    try {
      _viewModel.height = double.parse(height);
    } catch (e){

    }
  }

  @override
  void onWeightSubmitted(String weight) {
    try {
      _viewModel.weight = double.parse(weight);
    } catch (e){

    }
  }
}