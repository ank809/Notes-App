import 'package:cloud_firestore/cloud_firestore.dart';

class Data{
  String title;
  String desc;
  String uid;

  Data({required this.title, required this.desc, required this.uid});

  // app ---> firebase
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'desc':desc,
      'uid': uid
    };
  }

  
  // firebase ---> app

  static Data  fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String, dynamic>;
    return Data(title: snapshot['title'], desc: snapshot['desc'], uid: snapshot['uid']);
  }
}