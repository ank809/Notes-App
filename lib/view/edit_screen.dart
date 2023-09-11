import 'package:flutter/material.dart';
import 'package:notes_app/controllers/notes_controller.dart';

class Edit_Screen extends StatefulWidget {
  String desc;
  String title;
  String docID;
   Edit_Screen({super.key, required this.title, required this.desc, required this.docID});

  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  TextEditingController _titleController= new TextEditingController();
  TextEditingController _descriptionController= new TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState(){
    _titleController.text= widget.title;
    _descriptionController.text= widget.desc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 43, 72),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Color.fromARGB(255, 8, 43, 72),
         leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: const  Icon(Icons.arrow_back,
          color: Colors.white70,),
          ),
          actions:  [
          IconButton(
          onPressed: (){
            setState(() {
              NotesController.updateDocs(_titleController.text, _descriptionController.text, widget.docID,);
            });
          },
          icon: const  Icon(Icons.check,
          color: Colors.white70,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left:20.0, right: 20.0, top: 25.0),
            child: Form(
            child: 
            Column(
              children: [
                 TextField(
                  controller: _titleController,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 45.0,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
              ),
              const SizedBox(height: 20.0,),
                TextField(
                  controller: _descriptionController,
                  focusNode: myFocusNode,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                  ),
              )
              ]
            )),
          ),
        ),
      ),
    );
  }
}