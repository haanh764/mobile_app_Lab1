import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({required this.bmiString});

  final List<String> bmiString;
  final sharedPreferences = SharedPreferences.getInstance();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 99, 129),
        title: const Text("History (10 latest caculation)"),
      ),
      body: Center(
          child: Container(
            width: 320,
            height: 400,
            child: Card(
              color: Color.fromARGB(255, 198, 211, 255),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container( 
                          padding: EdgeInsets.all(20), 
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              Container( 
                                padding: EdgeInsets.all(10), 
                                margin: EdgeInsets.all(5),
                                child: Text("BMI HISTORY", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),),
                              Center(
                                child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: bmiString == null ? 0 : bmiString.length <= 10 ? bmiString.length : (bmiString.length > 10 ? 10 : bmiString.length),
                                itemBuilder: (context, index) {
                                  return Text(bmiString[index], style: TextStyle(fontSize: 16), textAlign: TextAlign.center,);
                                },
                              ),
                              )
                            ],
                          ), ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}// TODO Implement this library.
