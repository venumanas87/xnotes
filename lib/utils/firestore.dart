import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xnotes/utils/sharedpref_data.dart';

class FirestoreDb{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid;

  FirestoreDb(this.uid);

  addNote(String title,String text){

    print("adding to db $uid");
    firestore.collection("xnotes").doc("quickyquick").collection("ids")
        .doc(uid)
        .collection("notes").add({
      "title" : title,
      "text" : text
    });
  }
}