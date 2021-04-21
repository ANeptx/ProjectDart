import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

class MyServiceAdopter extends StatefulWidget {
  @override
  _MyServiceAdopterState createState() => _MyServiceAdopterState();
}

class _MyServiceAdopterState extends State<MyServiceAdopter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Adopter'),
      ),drawer: Drawer(child: MySignOut(),),
    );
  }
}
