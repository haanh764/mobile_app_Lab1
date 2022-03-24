import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'author.dart';
import 'history.dart';
import 'bmi_view.dart';
import 'bmi_presenter.dart';

class HomePage extends StatefulWidget {
  final BMIPresenter presenter;
  const HomePage(this.presenter, {Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver implements BMIView{
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  late String _weight, _height;
  var _message = '';
  var _bmiString = '';
  var _color = Color.fromARGB(0, 0, 0, 0);
  var _value = 0;
  var _heightMessage = '';
  var _weightMessage = '';
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();  
  var _formKey = GlobalKey<FormState>();

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    widget.presenter.bmiView = this;
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      errorMethodCount: 3,
      colors: true,
      printEmojis: true
    ),
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      logger.d("Debug Log: $state");     
    });
  }

  void handleRadioValueChanged(int? value) {
    this.widget.presenter.onOptionChanged(value!, heightString: _height, weightString: _weight );
  }

  void _calculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.widget.presenter.onCalculateClicked(_weight, _height);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _unitView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: Color.fromARGB(255, 52, 99, 129),
          value: 0, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Metric Unit',
          style: TextStyle(color: Color.fromARGB(255, 52, 99, 129)),
        ),
        Radio<int>(
          activeColor: Color.fromARGB(255, 52, 99, 129),
          value: 1, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Imperial Unit',
          style: TextStyle(color: Color.fromARGB(255, 52, 99, 129)),
        ),
      ],
    );

    var _mainPartView = Container(
      color: Color.fromARGB(255, 198, 211, 255),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(20.0),
      height: 300,
      child: SingleChildScrollView(  
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              heightFormField(context),
              weightFormField(),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: calculateButton()
              ,),
            ],
          ),
        ),
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: 
            InkWell( 
              onTap: () {
                showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
                child: Text(
                'Your BMI: $_bmiString',
                style: TextStyle(
                color: _color,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        )
      ),
        Padding(padding: EdgeInsets.all(2.0)),
        Center(
          child: Text(
            '$_message',
            style: TextStyle(
                color: _color,
                fontSize: 24.0,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 99, 129),
        centerTitle: true,
        title: Text("Welcome to BMI Calculator"),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: TextTheme().apply(bodyColor: Color.fromARGB(255, 255, 255, 255)),
                dividerColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.white)),
            child: PopupMenuButton<int>(
              color: Color.fromARGB(255, 236, 236, 236),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("BMI Calculator")),
                PopupMenuItem<int>(
                    value: 1, child: Text("History")),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 44, 44, 44),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Author")
                      ],
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ),
        ],
      ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            _unitView,
            Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            Padding(padding: EdgeInsets.all(5.0)),
            _resultView
          ],
        ));
  }
  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _calculator();
        history.insert(0, _bmiString);
        prefs.setStringList('history', history);
        // history = prefs.getStringList('history')!;
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 52, 99, 129),
      ),
      child: Text(
        'Calculate BMI',
        style: TextStyle(fontSize: 17, color: Colors.white70),
      ),
    );
  }

  TextFormField weightFormField() {
    return TextFormField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _weightFocus,
      onFieldSubmitted: (value){
        _weightFocus.unfocus();
        _calculator();
      },
      validator: (value) {
        if (value?.length == 0 || double.parse(value!) == 0.0) {
          return ('Weight is invalid. Weight must be > 0.0');
        }
      }, 
      onSaved: (value) {
        _weight = value!;
      },
      decoration: InputDecoration(
          hintText: _weightMessage,
          labelText: _weightMessage,
          icon: Icon(Icons.menu),
          fillColor: Colors.white
      ),
    );
  }

  TextFormField heightFormField(BuildContext context) {
    return TextFormField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _heightFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _heightFocus, _weightFocus);
      },
      validator: (value) {
        if (value?.length == 0 || double.parse(value!) == 0.0) {
          return ('Height is invalid. Height must be > 0.0');
        }
      }, 
      onSaved: (value) {
        _height = value!;
      },
      decoration: InputDecoration(
          hintText: _heightMessage,
          icon: Icon(Icons.assessment),
          fillColor: Colors.white,
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HistoryPage()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AuthorPage()));
        break;
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Your BMI Information'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('BMI = ' + _bmiString, textAlign: TextAlign.center),
        Text(_message, textAlign: TextAlign.center,),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: const Text('Close'),
      ),
    ],
  );
  }

  @override
  void updateBmiValue(String bmiValue, String message, Color color) {
    setState(() {
      _bmiString = bmiValue;
      _message = message;
      _color = color;
    });
  }

  @override
  void updateHeight({required String height}) {
    setState(() {
      _heightController.text = height != null?height:'';
    });
  }

  @override
  void updateUnit(int value, String heightMessage, String weightMessage) {
    setState(() {
      _value = value;
      _heightMessage = heightMessage;
      _weightMessage = weightMessage;
    });
  }

  @override
  void updateWeight({required String weight}) {
    setState(() {
      _weightController.text = weight != null?weight:'';
    });
  }
}
