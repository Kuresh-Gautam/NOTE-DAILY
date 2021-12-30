import 'dart:io';

import 'package:flutter/material.dart';

// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notely/models/note.dart';
import 'package:notely/screens/add_note_screen.dart';
import 'package:notely/screens/view_note_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N O T E L Y'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('note').listenable(),
          builder: (context, Box<Note> box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, i) {
                final note = box.getAt(i);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ViewNoteScreen(
                                    title: note?.title,
                                    description: note?.description,
                                    imageUrl: note?.imageUrl),
                              ),
                            );
                          },
                          leading: Image.file(
                            File(note!.imageUrl.toString()),
                          ),
                          title: Text(note.title.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => box.delete(i),
                          )),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddNoteScreen(),
              ),
            );
          },
          label: const Text('+ | Add Note')),
    );
  }
}
