import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/signIn.dart';

class ManageChoresPage extends StatefulWidget {
  @override
  ManageChores createState() => ManageChores();
}

class ManageChores extends State<ManageChoresPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  String description;
  String taskName;

  bool pressed = false;
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  
                  TextFormField(
                    controller: taskNameController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Chore/Task Name",
                      hintText: "Name",
                    ),
                  ),
                  RaisedButton(
                    child: Text('SELECT A DATE', style: TextStyle(color: Colors.white)),
                    color: Color(0xff283472),
                    onPressed: () {
                      _showDatePicker();
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    /*validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter the description';
                      }
                      return null;
                    },*/
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Description",
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Add Chore'),
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      globalKey.currentState.showSnackBar(SnackBar(
                        content: Text('Processing Data'),
                      )),
                      taskName = taskNameController.text,
                      description = descriptionController.text,
                      Firestore.instance.runTransaction((transaction) async {
                        await transaction.set(
                            Firestore.instance.collection("chores").document(),
                            {
                              'name': taskName,
                              'description': description,
                              'created_by': uid
                            });
                      }),
                      Navigator.of(context)
                          .pop(customController.text.toString())
                    }
                },
              ),
            ],
          );
        });
  }

  Future<String> _showDatePicker() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(2222));
    return picked.toString();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey)),
      child: ListTile(
        leading: Icon(Icons.check_circle),
        title: Text(document['name']),
        subtitle: Text(document['description']),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title:
                      Text('This will permanently delete: ' + document['name']),
                  content: Text("Are You Sure Want To Proceed ?"),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("YES"),
                        onPressed: () async {
                          await Firestore.instance
                              .collection('chores')
                              .document(document.documentID)
                              .delete();
                          Navigator.of(context).pop();
                        }),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Color(0xff283472),
        title: Text("Manage Chores"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection('chores').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');

            return ListView.builder(
              padding: EdgeInsets.only(bottom: 20),
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Chore',
        backgroundColor: Color(0xff283472),
        child: Icon(Icons.add),
        onPressed: () {
          createAlertDialog(context);
        },
      ),
    );
  }
}
