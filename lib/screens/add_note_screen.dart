import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:hive/hive.dart';
// ignore: unused_import
import 'package:hive_flutter/hive_flutter.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title;
  String? descraption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a note'),
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
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
              ],
            )),
      ),
    );
  }
}
