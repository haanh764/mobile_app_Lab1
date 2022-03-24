import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 99, 129),
        title: Text("Author Information"),
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
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/avatar.png'),
                          radius: 40,
                          backgroundColor: Color.fromARGB(255, 247, 247, 247),
                    ),
                    Container( 
                          padding: EdgeInsets.all(20), 
                          margin: EdgeInsets.all(5),
                          child: Text("NGO HA ANH", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),),
                    Container( 
                          padding: EdgeInsets.all(20), 
                          margin: EdgeInsets.all(5),
                          child: Text("Email: 269588@student.pwr.edu.pl", style: TextStyle(fontSize: 14)),),
                    Container( 
                          // padding: EdgeInsets.all(5), 
                          // margin: EdgeInsets.all(5),
                          child: Text("Github: https://github.com/haanh764", style: TextStyle(fontSize: 14)),),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

