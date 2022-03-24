import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:logger/logger.dart';
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  
  final logger = new Logger(
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
      print("My App State: $state");
      logger.d("Debug Log: $state");      
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new OrientationBuilder(
          builder: (context, orientation) {
            return new Center(
              child: new Text(
                "App with Activity Lifecycle State Logging",
                style: new TextStyle(
                    fontSize: 22.0,
                    color: orientation == Orientation.portrait
                        ? Color.fromARGB(255, 0, 76, 138)
                        : Color.fromARGB(255, 104, 7, 0)),
                    textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
