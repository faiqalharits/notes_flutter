import 'package:flutter/material.dart';
import 'package:local_storage/utils/notes_database.dart';
import '../models/note.dart';

class FormPage extends StatefulWidget {
  final Note? notes;
  const FormPage({
    Key? key,
    this.notes,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    if (widget.notes != null){
      titleController.text = widget.notes!.title;
      descController.text = widget.notes!.description;
    }
    super.initState();
  }

  Future updateNote() async {
    final notes = widget.notes!.copywith(
      title:  titleController.text,
      description: descController.text,
    );
    await NotesDatabase.instance.update(notes);
    Navigator.of(context).pop();
  }

  Future addNote() async {
    final note = Note(
      title: titleController.text,
      description: descController.text,
      time: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: (){
              if (widget.notes != null){
                updateNote();
              } else {
                addNote();
              }
            },
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 17,
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: ListView(
          children: [
            TextFormField(
              controller: titleController,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Title',
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: descController,
              maxLines: 16,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Catatan...',
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
