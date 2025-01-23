import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // open a textbox
  void openNoteBox () {
    showDialog(context: context,
     builder: (context) => AlertDialog(
      content: TextField(),
      actions: [
        // button to save
        ElevatedButton(onPressed: () {
          // add a new note
        }, child: Text("Add"))
      ],
     ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test page"),),
      floatingActionButton: FloatingActionButton(
      onPressed: openNoteBox,
      child: Icon(Icons.add),
      ),

    );
  }
}