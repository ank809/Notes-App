import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:notes_app/view/add_notes.dart';
import 'package:notes_app/view/edit_screen.dart';
import 'package:notes_app/view/widget/app_drawer.dart';
import 'dart:math';

import 'constants.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final random = Random();
  bool val= true;
  var theme1= const Color.fromARGB(255, 8, 43, 72);
  var theme2= Colors.black;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: val? theme1: theme2,
      appBar: AppBar(
        backgroundColor:val? theme1:theme2,
        title: const Text('Notes',
        style: TextStyle(
          fontSize: 30.0, ),
          ),
          actions:<Widget> [
            Switch(value: val, 
            onChanged: (t){
              setState(() {
                val=t;
              });
            }),
          ],
          ),
      drawer: const AppDrawer(),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: NotesController.itemStream(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const  Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return const Center(child: Text('No data found'),);
            }
            if(snapshot.hasError){
              return Center(child: Text(('Error : ${snapshot.error}')));
            }

            final List<DocumentSnapshot> documents= snapshot.data!.docs;
            return GridView.builder(
              gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
                //mainAxisSpacing:,
                childAspectRatio: 1),
              itemCount: documents.length,
              itemBuilder: (context, index){
                int len = colors.length;
                int randVal = random.nextInt(len);
                final item= documents[index].data() as Map<String, dynamic>;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  color: colors[randVal],
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.to(Edit_Screen(
                        title: item['title'],
                        desc: item['desc'],
                        docID: documents[index].id.toString(),
                        val: val
                      ));
                    },
                    title: Text(item['title'],
                    style: const TextStyle(color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                    ),),
                    subtitle: Text(
                      item['desc'].length> 50
                      ? item['desc'].substring(0, 45)+"..."
                      :item['desc'],
                    style: const TextStyle(color: Colors.black,
                    fontSize: 22.0),),
                    onLongPress: () {
                      showDialog(
                        context: context,
                       builder: (context){
                        return AlertDialog(
                          title: const Text('Are you sure you want to delete'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                NotesController.deleteData(documents[index].id);
                                Navigator.pop(context);
                              },
                               child: const Text('Yes')),

                               TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text('No'))
                          ],
                        );
                       });
                    } ,
                  ),
                );
              }
              );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(AddNotes(val: val,));
          },
          child: Icon(Icons.add,
          size: 27.0,),
          backgroundColor: Color.fromARGB(255, 7, 51, 102),
        ),
    );
  }
}