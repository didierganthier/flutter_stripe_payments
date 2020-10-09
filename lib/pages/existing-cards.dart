import 'package:flutter/material.dart';

class ExistingCardsPage extends StatefulWidget {
  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose existing card"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text("existing cards page"),
      ),
    );
  }
}
