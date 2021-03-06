import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/authen.dart';
import 'package:flutter_application_1/states/create_account.dart';
import 'package:flutter_application_1/states/my_service_adopter.dart';
import 'package:flutter_application_1/states/my_service_user.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

class PageRouter {
  static final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myServiceUser': (BuildContext context) => MyServiceUser(),
  '/myServiceAdopter': (BuildContext context) => MyServiceAdopter(),
  '/mySignOut': (BuildContext context) => MySignOut(),
};
}