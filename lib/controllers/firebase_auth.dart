import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/model/users.dart';
import 'package:notes_app/view/home.dart';

class Auth extends GetxController{
  static Auth instance= Get.find();

  // for signing up
  void signup(String name, String email, String password) async{
    try{
      if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
        UserCredential userCredential= await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email, password: password);

        MyUser myUser= MyUser(email: email, name: name, uid: userCredential.user!.uid);
        
        // to store data in firestore for future use
        await FirebaseFirestore.instance.
        collection('users').doc(userCredential.user!.uid)
        .set(myUser.toJson()).then((value) => 
        Get.snackbar('Congratulations😀', 'Your account has been created successfully'));
        Get.offAll(HomePage());
      }
      else{
        Get.snackbar('Incomplete details', 'Fill all the fields');
      }
    }catch(error){  // here error is just a variable
  log(error.toString());
    }
    
  }
}