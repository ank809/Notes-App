import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/controllers/notes_controller.dart';

class AddNotes extends StatefulWidget {
  final bool val;
  const AddNotes({super.key, required this.val});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  final TextEditingController _titleController=  TextEditingController();
  final TextEditingController _descriptionController= TextEditingController();

  static DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMEd().format(now);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.val==false? Colors.black:const Color.fromARGB(255, 8, 43, 72),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:widget.val==false? Colors.black:const Color.fromARGB(255, 8, 43, 72),
         leading: IconButton(
          onPressed: (){
              Navigator.pop(context);
          },
          icon: const  Icon(Icons.arrow_back,
          color: Colors.white70,),
          ),
          actions:  [
          IconButton(
          onPressed: (){
            setState(() {
              NotesController.addNotes(_titleController.text, _descriptionController.text);
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
            margin:const  EdgeInsets.only(left:20.0, right: 20.0, top: 25.0),
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
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
                TextField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type something here...',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    hintStyle: TextStyle(color: Colors.white),
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