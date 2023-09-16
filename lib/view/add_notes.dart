import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddNotes extends StatefulWidget {
  final bool val;
  const AddNotes({super.key, required this.val});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
   bool _speechEnabled = false;
  String _lastWords = '';
  Timer? _speechTimer;
  final TextEditingController _titleController=  TextEditingController();
  final TextEditingController _descriptionController= TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  static DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMEd().format(now);

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    if (await _speechToText.initialize()) {
      _speechToText.listen(onResult: _onSpeechResult);
      setState(() {
        _speechEnabled = true;
      });

      // Start a timer to check for inactivity and stop speech recognition
      _speechTimer = Timer(const Duration(seconds: 10), () {
        _stopListening();
      });
    }
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() {
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
    setState(() {
      _speechEnabled = false;
    });

    // Cancel the timer when you manually stop speech recognition
    _speechTimer?.cancel();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      setState(() {
        String newText = result.recognizedWords;
        String currentText = _descriptionController.text;
        String updatedText = currentText +
            ' ' +
            newText; // Append recognized text to the existing text
        _descriptionController.text = updatedText;
        _lastWords = updatedText; // Update _lastWords for reference
      });

      // Reset the timer when speech recognition is active
      _speechTimer?.cancel();
      _speechTimer = Timer(const Duration(seconds: 10), () {
        _stopListening();
      });
    }
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(!_speechEnabled){
            _startListening();
          }
          else{
            _stopListening();
          }
        },
      child: _speechEnabled? Icon(Icons.mic):Icon(Icons.mic_off)),
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