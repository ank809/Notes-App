import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/model/data.dart';
import 'package:notes_app/view/home.dart';

class NotesController{
  
  // add notes to firebase

  static void addNotes(String title, String desc) async{
    try{
       if(title.isNotEmpty && desc.isNotEmpty){
         Data data= Data(title: title, desc: desc, uid: FirebaseAuth.instance.currentUser!.uid);
         await FirebaseFirestore.instance.
         collection('notes')
         .doc()
         .set(data.toJson())
         .then((value) => Get.snackbar('Note saved successfully ', ''));
         Get.offAll(HomePage());

       }
    }catch(e){
      Get.snackbar('Error', e.toString());
      
    }
  }

  // get snapshots
  static Stream<QuerySnapshot> itemStream(){
    final user= FirebaseAuth.instance.currentUser;
    if(user!=null){
    return FirebaseFirestore.instance.collection('notes')
    .where('uid' , isEqualTo: user.uid).snapshots();
    }
    else{
      return Stream.empty();
    }
  }

  // delete the documents

  static void deleteData(String documentID) async{
    await FirebaseFirestore.instance.collection('notes').doc(documentID).delete();
  }

  // updating the document

 static void updateDocs(String title, String desc, String docID) async{
    Data data= Data(title: title, desc: desc, uid: FirebaseAuth.instance.currentUser!.uid);
    try{
      await FirebaseFirestore.instance.collection('notes').doc(docID).update(
      data.toJson()).then((value) => 
      Get.offAll(HomePage()));
    }catch(e){
      Get.snackbar('Error',e.toString());
    }
  }
}