import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose existing card"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text("Home Page"),
      ),
    );
  }
}
