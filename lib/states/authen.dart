import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/utility/dialog.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user_model.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screenWidth, screenHeight;
  bool redEyE = true;
  String typeUser = 'User', name, email, uid, user, password, contact;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: buildCreateAccount(),
      body: SafeArea(
        child: Stack(
          children: [
            MyStyle().buildBackground(screenWidth, screenHeight),
            Positioned(
              top: 100,
              left: 123,
              child: buildLogo(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildUser(),
                  buildPassword(),
                  buildSignInEmail(),
                  buildSignInGoogle(),
                  buildSignInFacebook(),
                  SizedBox(
                    height: screenHeight * 0.2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
        ),
        Text(
          'No Account?',
          style: MyStyle().lightStyle(),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/createAccount'),
          child: Text(
            'Create Account',
            style: MyStyle().pinkStyle(),
          ),
        )
      ],
    );
  }

  Container buildSignInEmail() => Container(
        margin: EdgeInsets.only(top: 16),
        child: SignInButton(
          Buttons.Email,
          onPressed: () {
            if ((password?.isEmpty ?? true) || (user?.isEmpty ?? true)) {
              normalDialog(context, 'NOTICE', 'Please Fill Completely.');
            } else {
              checkAuthen();
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  Container buildSignInGoogle() => Container(
        margin: EdgeInsets.only(top: 8),
        child: SignInButton(
          Buttons.Google,
          onPressed: () => processSignInWithGoogle(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  Future<Null> processSignInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) async {
        name = value.displayName;
        email = value.email;
        await value.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: value2.idToken,
            accessToken: value2.accessToken,
          );
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value3) async {
            uid = value3.user.uid;
            print(
                'Login With Gmail Success value with Name = $name, email = $email, uid = $uid');
            await FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .snapshots()
                .listen((event) {
              print('event ==> ${event.data()}');
              if (event.data() == null) {
                // Call TypeUser
                callTypeUserDialog();
              } else {
                // Route to Service by TypeUser
                print('Route to Service');
              }
            });
          });
        });
      });
    });
  }

  Future<Null> insertValueCloudFirestore() async {
    UserModel model = UserModel(name: name, email: email, typeuser: typeUser);
    Map<String, dynamic> data = model.toMap();

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(data)
          .then((value) {
        switch (typeUser) {
          case 'User':
            Navigator.pushNamedAndRemoveUntil(
                context, '/myServiceUser', (route) => false);
            break;
          case 'Adopter':
            Navigator.pushNamedAndRemoveUntil(
                context, '/myServiceAdopter', (route) => false);
            break;
          default:
        }
      });
    });
  }

  Future<Null> callTypeUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStage) {
            return SimpleDialog(
              title: ListTile(
                //leading: MyStyle().showLogo(),
                title: Text('Type User?'),
                subtitle: Text('Please Coose Type User.'),
              ),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: 200,
                  child: Column(
                    children: [
                      RadioListTile(
                        value: 'User',
                        groupValue: typeUser,
                        onChanged: (value) {
                          setState(() {
                            typeUser = value;
                          });
                        },
                        title: Text('User'),
                      ),
                      RadioListTile(
                        value: 'Adopter',
                        groupValue: typeUser,
                        onChanged: (value) {
                          setState(() {
                            typeUser = value;
                          });
                        },
                        title: Text('Adopter'),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print(
                        'Call Type User, name = $name, email = $email, typeUser = $typeUser, uid = $uid');
                    insertValueCloudFirestore();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Container buildSignInFacebook() => Container(
        margin: EdgeInsets.only(top: 8),
        child: SignInButton(
          Buttons.Facebook,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.6,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Email :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() => Container(
        margin: EdgeInsets.only(top: 16),
        width: screenWidth * 0.6,
        child: TextField(
          obscureText: redEyE,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  redEyE
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_sharp,
                  color: MyStyle().darkColor,
                ),
                onPressed: () {
                  setState(() {
                    redEyE = !redEyE;
                  });
                }),
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

  buildLogo() {
    return Container(width: screenWidth * 0.4, child: MyStyle().showLogo());
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      UserModel model = UserModel(
          email: user, name: name, typeuser: typeUser, phone: contact);
      Map<String, dynamic> data = model.toMap();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) {
        switch (typeUser) {
          case 'User':
            Navigator.pushNamedAndRemoveUntil(
                context, '/myServiceUser', (route) => false);
            break;
          case 'Adopter':
            Navigator.pushNamedAndRemoveUntil(
                context, '/myServiceAdopter', (route) => false);
            break;
          default:
        }
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }
}
