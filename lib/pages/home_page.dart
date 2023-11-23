import 'package:flutter/material.dart';
import 'package:local_storage/pages/detail_page.dart';
import 'package:local_storage/pages/form_page.dart';
import 'package:local_storage/widgets/card_widgets.dart';
import '../models/note.dart';
import '../utils/notes_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
      id: 1,
      title: 'work',
      description: 'saya',
      time: DateTime.now(),
    )
  ];
  bool isLoading = false;
  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(notes: notes[index]);
                      }));
                      refreshNote();
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNote();
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
