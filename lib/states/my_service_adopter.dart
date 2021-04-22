import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/states/cats.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_application_1/widget/my_signout.dart';
import 'package:flutter_application_1/widget/information.dart';

class MyServiceAdopter extends StatefulWidget {
  @override
  _MyServiceAdopterState createState() => _MyServiceAdopterState();
}

class _MyServiceAdopterState extends State<MyServiceAdopter> {
  double screenWidth, screenHeight;
  String name;
  UserModel model;

  @override
  final List<String> imageList = [
    "https://img.joemonster.org/i/2019/04/Screenshot_1-20190429200143.jpg",
    "https://data.whicdn.com/images/246599981/original.jpg",
    "https://krasivosti.pro/uploads/posts/2021-04/1617975209_16-p-kot-britanets-zolotaya-shinshilla-19.jpg",
  ];
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome Adopter'),
          backgroundColor: MyStyle().pinkColor,
        ),
        floatingActionButton: buildAdoption(),
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
        body: Container(

          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/20/3b/da/203bda8e39c9a6ba19a7c4758ad15acf.jpg'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

               Container(
                 child: Column(
                  
                   children: [
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Text('Your Best Friend',style : TextStyle(fontSize : 24))),
                         Align(
                   alignment: Alignment.centerLeft,
                   child: Text('is waiting',style : TextStyle(fontSize : 24))),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Text('Let your love change the world!',style : TextStyle(fontSize : 24))),
                   ],
                 ),
               ),
             
              
              CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items: imageList
                    .map((e) => GestureDetector(
                          onTap: () {
                            print(e);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Cat(catLink: e,),)); // จะให้ไปหน้าไหน ? หน้า cats
                          },
                          child: ClipRRect(
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
                          ),
                        ))
                    .toList(),
              ),
            ],
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
          Information(
            userModel: model,
          );
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

  buildAdoption() {
    return Container();
    //         return Container(
    //   margin: EdgeInsets.only(top: 24),
    //   width: screenWidth * 0.6,
    //   child: ElevatedButton.icon(
    //     style: ElevatedButton.styleFrom(
    //       primary: MyStyle().lightpink,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(30),
    //       ),
    //       // GestureDetector(
    //       //   child: Image(image: AssetImage('')),
    //       //   onTap: (){
    //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => Cat(),));
    //       //   },
    //       // ),
    //   ),
    // ));
  }
}
