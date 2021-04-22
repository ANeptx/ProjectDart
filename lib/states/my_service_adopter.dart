import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

class MyServiceAdopter extends StatefulWidget {
  @override
  _MyServiceAdopterState createState() => _MyServiceAdopterState();
}

class _MyServiceAdopterState extends State<MyServiceAdopter> {
  String name;
  UserModel model;

  @override
  final List<String> imageList = [
    "https://img.joemonster.org/i/2019/04/Screenshot_1-20190429200143.jpg",
    "https://data.whicdn.com/images/246599981/original.jpg",
    "https://krasivosti.pro/uploads/posts/2021-04/1617975209_16-p-kot-britanets-zolotaya-shinshilla-19.jpg",
  ];
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome Adopter'),
          backgroundColor: MyStyle().pinkColor,
        ),
         drawer: Drawer(
        child: Stack(
          children: [
            MySignOut(),
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuInformation(),
              ],
            ),
          ],
        ),
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
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(
                            e,
                            width: 1000,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );

  }
   ListTile buildMenuInformation() {
    return ListTile(
      leading: Icon(
        Icons.article,
        size: 36,
      ),
      title: Text('Information'),
      subtitle: Text('รายละเอียดของผู้ใช้ที่ล็อกอินอยู่'),
      onTap: () {
        setState(() {
         // current = Information(userModel: model,);
        });
        Navigator.pop(context);
      },
    );
  }

    UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      accountName: Text(name == null ? 'Name ?' : name),
      accountEmail: Text('Login'),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }
}
