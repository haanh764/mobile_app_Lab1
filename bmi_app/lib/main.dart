import 'package:flutter/material.dart';
import 'homepage.dart';
import 'bmi_presenter.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YourBMI.com',
      home: HomePage(BasicBMIPresenter(), title: ''),
    );
  }
}
