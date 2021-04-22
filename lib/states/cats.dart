import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_style.dart';

class Cat extends StatefulWidget {
  final String catLink;

  const Cat({Key key, this.catLink}) : super(key: key);

  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  double boxSize = 80.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                  child: Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(widget.catLink)),
      Container(
          child: Column(
        children: [
       
          Align(
              alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical : 25.0),
                          child: Text(
                'Cat - Male',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
                        ),
          ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  width: boxSize,
                  height: boxSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(Icons.star),
                      Text('Neat'),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  width: boxSize,
                  height: boxSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star),
                      Text('Friendly'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical : 8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    width: boxSize,
                    height: boxSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(Icons.star),
                        Text('Vocal'),
                      ],
                    ),
                  ),
                ),
              ],
          ),
          Align(
               alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical : 8.0),
                child: Text('Summary',style : TextStyle(fontSize: 20)),
              )),
          Align(
               alignment: Alignment.centerLeft,
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi')),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Expanded(
                   
                    child: ElevatedButton(onPressed: () {}, child: Text('Adoption'))),
                    SizedBox(width: 20,),
                  Flexible(
                    flex:1 ,
                    child: ElevatedButton(onPressed: () {}, child: Text('Like'))),
                ],
            ),
          )
        ],
      )),
    ])),
            )));
  }
}
