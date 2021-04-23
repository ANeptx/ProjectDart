import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ActionData {
  String collection_name = 'User';
  FirebaseFirestore firestore_db;

  ActionData({String collectionName}) {
    this.collection_name = collectionName;
    firestore_db = FirebaseFirestore.instance;
  }

  getAllData() async {
    // retrivie data

  
    final collection = firestore_db.collection(collection_name);
    QuerySnapshot res = await collection.get();
    final dataList = res.docs.map((doc) => doc.data()).toList();
    return dataList; // return type List[]

  

  }
  /*  
    Example
    final my_data = ActionData().getAllData()
  */

  addNewRecord({Map<String, dynamic> data}) async {
    final collection = firestore_db.collection(collection_name);
    collection.doc(data['name']).set(data);
  }

  /*  
    Example
    ActionData().addNewRecord(
      {
        "key1" : value,
        "key2" : value,
        "key3" : value,
      }
    );
  */

  updateData(String docName, {Map<String, dynamic> editedData}) async {
    final collection = firestore_db.collection(collection_name);
    collection.doc(docName).update(editedData);
  }

  /*  
    Example
    ActionData().updateData(
      'My_Doc'
      {
        "key1" : value,
        "key2" : value,
        "key3" : value,
      }
    );
  */

  deleteMenu(String docName) async {
    // Delete with doc name or record name
    final collection = firestore_db.collection(collection_name);
    collection.doc(docName).delete();
  }
}