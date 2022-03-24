// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage();

  // late List<String> bmiString = bmiString;
  // List<String> history = [];

  get bmiString => _load_history();

  Future<List<String>> _load_history() async {
    final prefs = await SharedPreferences.getInstance();
    var bmiString = prefs.getStringList('history')!;
    return bmiString;
  }
     
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
                                child: FutureBuilder<List<String>> (future: bmiString,
                                  builder: (context, projectSnap) {
                                    if (projectSnap.connectionState == ConnectionState.none &&
                                        projectSnap.hasData == null) {
                                      //print('project snapshot data is: ${projectSnap.data}');
                                      return Container();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: projectSnap.data == null ? 0 : projectSnap.data!.length <= 10 ? projectSnap.data!.length : (projectSnap.data!.length > 10 ? 10 : projectSnap.data!.length),
                                    itemBuilder: (context, index) {
                                       return Text(projectSnap.data![index], style: TextStyle(fontSize: 16), textAlign: TextAlign.center,);
                                    });
                                }
                              )
                              )],
                          ), ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
