import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:notes_app/view/add_notes.dart';
import 'package:notes_app/view/edit_screen.dart';
import 'package:notes_app/view/widget/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 43, 72),
      appBar: AppBar(backgroundColor:  Color.fromARGB(255, 8, 43, 72),),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: NotesController.itemStream(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return Center(child: Text('No data found'),);
            }
            if(snapshot.hasError){
              return Center(child: Text(('Error : ${snapshot.error}')));
            }

            final List<DocumentSnapshot> documents= snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index){
                final item= documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
                    Get.to(Edit_Screen(
                      title: item['title'],
                      desc: item['desc'],
                      docID: documents[index].id.toString(),
                    ));
                  },
                  title: Text(item['title'],
                  style: TextStyle(color: Colors.white),),
                  subtitle: Text(item['desc'],
                  style: TextStyle(color: Colors.white),),
                  trailing: IconButton(
                    onPressed: (){
                      NotesController.deleteData(documents[index].id);
                    },
                    icon: const  Icon(Icons.delete,
                    color: Colors.red),
                    ),
                );
              }
              );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.off(AddNotes());
          },
          child: Icon(Icons.add),
        ),
    );
  }
}