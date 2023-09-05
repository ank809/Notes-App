import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{

  final String name;
  final String uid;
  final String email;

  MyUser({required this.email, required this.name, required this.uid});

  // app ---> firebase
  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email':email,
      'uid':uid,
    };
  }

  
  // firebase ---> app

  static MyUser fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String, dynamic>;
    return MyUser(email: snapshot['email'], name: snapshot['name'], uid: snapshot['uid']);
  }
}