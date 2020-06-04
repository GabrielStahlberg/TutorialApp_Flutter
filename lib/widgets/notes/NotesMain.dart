import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/notes/model/Note.dart';
import 'package:tutorial_app/helper/DatabaseNotesHelper.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NotesMain extends StatefulWidget {
  @override
  _NotesMainState createState() => _NotesMainState();
}

class _NotesMainState extends State<NotesMain> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  var _database = DatabaseNotesHelper();
  List<Note> _notes = List<Note>();

  @override
  void initState() {
    super.initState();
    _retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My notes"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];

                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text("${_dateFormatter(note.date)} - ${note.description}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showRegisterScreen(note: note);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _deleteNote(note.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          _showRegisterScreen();
        }
      ),
    );
  }

  _showRegisterScreen({Note note}) {
    String saveOrUpdateText = "";
    if(note == null) {
      _titleController.text = "";
      _descriptionController.text = "";
      saveOrUpdateText = "Save";
    } else {
      _titleController.text = note.title;
      _descriptionController.text = note.description;
      saveOrUpdateText = "Update";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$saveOrUpdateText note"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Enter title..."
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter description..."
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")
              ),
              FlatButton(
                  onPressed: () {
                    _saveEditNote(selectedNote: note);
                    Navigator.pop(context);
                  },
                  child: Text(saveOrUpdateText)
              )
            ],
          );
        }
    );
  }

  _retrieveNotes() async {
    List retrievedNotes = await _database.findAll();
    List<Note> tempList = List<Note>();

    for(var item in retrievedNotes) {
      Note note = Note.fromMap(item);
      tempList.add(note);
    }

    setState(() {
      _notes = tempList;
    });
    tempList = null;
  }

  _deleteNote(int id) async {
    await _database.delete(id);
    _retrieveNotes();
  }

  _saveEditNote({Note selectedNote}) async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    int result;
    if(selectedNote == null) {
      Note note = Note(title, description, DateTime.now().toString());
      result = await _database.save(note);
    } else {
      selectedNote.title = title;
      selectedNote.description = description;
      selectedNote.date = DateTime.now().toString();
      result = await _database.update(selectedNote);
    }

    _titleController.clear();
    _descriptionController.clear();

    _retrieveNotes();
  }

  _dateFormatter(String date) {
    initializeDateFormatting("pt_BR");
    var formatter = DateFormat.yMd("pt_BR");

    DateTime convertedDate = DateTime.parse(date);
    return formatter.format(convertedDate);
  }
}
