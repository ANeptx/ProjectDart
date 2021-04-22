import 'package:flutter/material.dart';

class Cat extends StatefulWidget {
  final String catLink;

  const Cat({Key key, this.catLink}) : super(key: key);
  
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(child: Column(
        children: [
          Image.network(widget.catLink)
        ],
      ),),),
    );
  }
}