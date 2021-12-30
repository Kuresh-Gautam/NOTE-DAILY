import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notely/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _image;
  String? title;
  String? description;

  getImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final image = await ImagePicker.platform.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      Hive.box<Note>('note').add(
          Note(title: title, description: description, imageUrl: _image!.path));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a note'),
        actions: [
          IconButton(
              onPressed: () {
                submitData();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  autocorrect: false,
                  minLines: 2,
                  maxLines: 10,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _image == null
                      ? Container()
                      : Image.file(
                          File(_image!.path),
                        ),
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
