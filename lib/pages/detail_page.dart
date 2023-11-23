import 'package:flutter/material.dart';
import 'package:local_storage/models/note.dart';
import 'package:local_storage/pages/form_page.dart';
import 'package:local_storage/utils/notes_database.dart';

class DetailPage extends StatefulWidget {
  final Note notes;
  const DetailPage({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  late Note notes;
  Future refreshNote() async {
    notes = await NotesDatabase.instance.readNote(widget.notes.id!);
    setState(() {});
  }
  @override
  void initState() {
    notes = widget.notes;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(notes.title),
        actions:  [
          InkWell(
            onTap: () async {
             await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return FormPage(notes: widget.notes);
              }));
              refreshNote();
            },
            child: const Icon(
              Icons.edit_note_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        child: ListView(
          children: [
            Text(
              notes.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              notes.description,
              style: const TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
