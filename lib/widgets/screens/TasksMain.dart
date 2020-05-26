import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class TasksMain extends StatefulWidget {
  @override
  _TasksMainState createState() => _TasksMainState();
}

class _TasksMainState extends State<TasksMain> {

  List _tasksList = [];
  Map<String, dynamic> _lastTaskRemoved = Map();
  bool _isUpdate = false;
  TextEditingController _taskController = TextEditingController();

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/datas.json");
  }

  _saveTask() {
    if(_isUpdate) {
      _tasksList.remove(_lastTaskRemoved);
    }
    String taskTitle = _taskController.text;

    Map<String, dynamic> task = Map();
    task["title"] = taskTitle;
    task["done"] = false;

    setState(() {
      _tasksList.add(task);
    });
    _saveFile();
    _taskController.text = "";
    _isUpdate = false;
  }

  _saveFile() async {
    var file = await _getFile();

    String datas = json.encode(_tasksList);
    file.writeAsString(datas);
  }

  _retrieveFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch(e) {
      return null;
    }
  }

  _refreshList() {
    _retrieveFile().then((datas){
      setState(() {
        _tasksList = json.decode(datas);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Test"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasksList.length,
              itemBuilder: createListItem
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 6,
        child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
              builder: createDialog
            );
          }
      ),
    );
  }

  Widget createDialog(context) {
    _taskController.text = _isUpdate ? _lastTaskRemoved["title"] : "";
    return AlertDialog(
      title: Text("New task"),
      content: TextField(
        controller: _taskController,
        decoration: InputDecoration(
          labelText: "Enter your task",
        ),
        onChanged: (text) {

        },
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            if(_isUpdate) {
              setState(() {
                _refreshList();
              });
              _isUpdate = false;
            }
            Navigator.pop(context);
          }
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            _saveTask();
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget createListItem(context, index) {
    return Dismissible(
        background: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.edit,
                color: Colors.white,
              )
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        direction: DismissDirection.horizontal, //DEFAULT
        onDismissed: (direction){
          _lastTaskRemoved = _tasksList[index];
          if(direction == DismissDirection.endToStart) {
            _tasksList.removeAt(index);
            _saveFile();
            final snackbar = SnackBar(
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    setState(() {
                      _tasksList.insert(index, _lastTaskRemoved);
                    });
                    _saveFile();
                  }
              ),
              content: Text("Task removed")
            );
            Scaffold.of(context).showSnackBar(snackbar);
          } else {
            _isUpdate = true;
            showDialog(
                context: context,
                builder: createDialog
            );
          }
        },
        key: UniqueKey(),
        child: CheckboxListTile(
          title: Text(_tasksList[index]["title"]),
          value: _tasksList[index]["done"],
          onChanged: (value) {
            setState(() {
              _tasksList[index]["done"] = value;
            });
            _saveFile();
          },
        )
    );
  }
}
