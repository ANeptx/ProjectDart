import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/my_signout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyServiceAdopter extends StatefulWidget {
  @override
  _MyServiceAdopterState createState() => _MyServiceAdopterState();
}

class _MyServiceAdopterState extends State<MyServiceAdopter> {
  @override
  final List<String> imageList = [
    
  ];
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome Adopter'),
        ),
        drawer: Drawer(
          child: MySignOut(),
        ),
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: true,
            ),
            items: imageList
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
