import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_skipper/text_dialog_widget.dart';

void main() {
  runApp(MaterialApp(
    home: BlogPageTable(),
  ));
}

class User {
  final int userID, id;
  final String title;

  User(this.userID, this.id, this.title);
}

class BlogPageTable extends StatefulWidget {
  const BlogPageTable({Key? key}) : super(key: key);

  @override
  _BlogPageTableState createState() => _BlogPageTableState();
}

class _BlogPageTableState extends State<BlogPageTable> {
  final List<Map> _desData = List.generate(5, (i) {
    return {
      "Blog Name": "Blog $i",
      "Description": "Desc $i",
      "Status": "Active"
    };
  });

  @override
  Widget build(BuildContext context) {
    /*Future getUserData() async {
      var response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
      var jsonData = jsonDecode(response.body);
      List<User> users = [];
      for (var u in jsonData) {
        User user = User(
          u["userId"],
          u["id"],
          u["title"],
        );
        users.add(user);
      }
      // ignore: avoid_print
      print(users.length);
      return users;
    }*/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          child: DataTable(
            columnSpacing: 20.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Description',
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                ),
              ),
              DataColumn(
                label: Text(
                  'Actions',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: _desData.map((item) {
              return DataRow(cells: [
                DataCell(Text(item['Blog Name'])),
                DataCell(Text(item['Description'])),
                DataCell(Text(item['Status'])),
                DataCell(ActionItem())
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ActionItem extends StatelessWidget {
  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(
        u["userId"],
        u["id"],
        u["title"],
      );

      users.add(user);
    }
    // ignore: avoid_print
    print(users.length);
    return users;
  }

  const ActionItem({Key? key}) : super(key: key);

  Future<void> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Name"),
            content: TextField(
              controller: customController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  'Update',
                  //style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  createAlertDialog2(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Description"),
            content: TextField(
              controller: customController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Description',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Update'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  createAlertDialog3(BuildContext context) {
    TextEditingController customController = TextEditingController();
    
    return showDialog(
      
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Status"),
            content: TextField(
              controller: customController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Status',
                border: OutlineInputBorder(),
              ),
            ),
            
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Update'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
                
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
            onPressed: () {
              createAlertDialog3(context);
              createAlertDialog2(context);
              createAlertDialog(context);
              //_TextDialogWidgetState();
              //getUserData();
            },

            //e: prefer_const_constructors
            icon: Icon(
              Icons.edit,
              color: Colors.grey,
            )),
        IconButton(
            onPressed: () {
              const ActionItem();
            },
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.delete,
              // ignore: prefer_const_constructors
              color: Color.fromARGB(255, 193, 111, 111),
            )),
      ],
    );
  }
}
/*class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}


class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            // ignore: prefer_const_constructors
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(controller.text),
          )
        ],
      );
}*/
