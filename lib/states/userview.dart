import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/action/fire_store.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List users = [];
  void getData() async {
    await Firebase.initializeApp();
    final result = await ActionData(collectionName: 'User').getAllData();
    print(result);
    setState(() {
      users = result;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Card userCard({
    String address,
    String email,
    String gender,
    String name,
    String phone,
    String uid,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,), onPressed: () async {
                await Firebase.initializeApp();
                ActionData(collectionName : 'User').deleteMenu(uid);
                getData();
              }),),
            Text('$name'),
            Text('$email'),
            Text('$address'),
            Text('$gender'),
            Text('$phone'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: users.isEmpty ? Center(
          child: Text('ไม่มีข้อมูล'),
        ) : ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => userCard(
            address: users[index]['address'],
            email: users[index]['email'],
            name: users[index]['name'],
            phone: users[index]['phone'],
            gender: users[index]['gender'],
            uid :users[index]['uid'],
          ),
        ));
  }
}
