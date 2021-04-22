import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/states/my_service_adopter.dart';
import 'package:flutter_application_1/utility/dialog.dart';
import 'package:flutter_application_1/utility/my_style.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double screenWidth, screenHeight;
  String name, typeUser, user, password, contact;

  Container buildDisplayName() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: screenWidth * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.pets_outlined,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Name : ',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: screenWidth * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Username :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: screenWidth * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Password :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildContact() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: screenWidth * 0.6,
      child: TextField(
        onChanged: (value) => contact = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone_outlined,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Phone Number :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Us!'),
        backgroundColor: MyStyle().pinkColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildDisplayName(),
              buildUser(),
              buildPassword(),
              buildContact(),
              buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  // Container buildTypeUser() {
  //   return Container(
  //     width: screenWidth * 0.6,
  //     child: RadioListTile(
  //       value: 'User',
  //       groupValue: typeUser,
  //       onChanged: (value) {
  //         setState(() {
  //           typeUser = value;
  //         });
  //       },
  //       title: Text(
  //         'User',
  //         style: MyStyle().darkStyle(),
  //       ),
  //     ),
  //   );
  // }

  // Container buildTypeAdopter() {
  //   return Container(
  //     width: screenWidth * 0.6,
  //     child: RadioListTile(
  //       value: 'Adopter',
  //       groupValue: typeUser,
  //       onChanged: (value) {
  //         setState(() {
  //           typeUser = value;
  //         });
  //       },
  //       title: Text(
  //         'Adopter',
  //         style: MyStyle().darkStyle(),
  //       ),
  //     ),
  //   );
  // }

  Container buildCreateAccount() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: screenWidth * 0.6,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().lightpink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true) ||
              (contact?.isEmpty ?? true)) {
            // ?? คือการ AND
            //  print('Have Space.');
            normalDialog(
                context, 'NOTICE', 'Please fill your information completely.');
          } else {
            createAccountAndInsertInformation();
          }
        },
        icon: Icon(Icons.supervisor_account),
        label: Text('Create Account'),
      ),
    );
  }

  Future<Null> createAccountAndInsertInformation() async {
    await Firebase.initializeApp().then((value) async {
      //print('### Firebase Initialize Success ###');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print('Create Account Success.');
        await value.user.updateProfile(displayName: name).then((value2) async {
          String uid = value.user.uid;
          print('Update Profile Success and UID = $uid');

          UserModel model = UserModel(
              email: user, name: name, phone: contact,password: password);
          Map<String, dynamic> data = model.toMap();

          await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .set(data);
          
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyServiceAdopter(),), (route) => false);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/myServiceAdopter', (route) => false);
        });
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }
}

