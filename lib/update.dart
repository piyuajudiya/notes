import 'package:flutter/material.dart';
import 'package:notes/DBHelper.dart';
import 'package:notes/main.dart';
import 'package:sqflite/sqflite.dart';

class update extends StatefulWidget {
  Map m;

  update(this.m);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  Database? db;
  List<Map<String, Object?>> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBhelper().opendb().then((value) {
      db = value;
      t.text = '${widget.m!['title']}';
      t1.text = '${widget.m!['subtitle']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: t,
              maxLength: 30,
              cursorHeight: 30,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: t1,
              maxLength: 500,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note",
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  String qry1 =
                      "update notes set title='${t.text}',subtitle='${t1.text}' where id='${widget.m!['id']}'";
                  db!.rawUpdate(qry1).then((value) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return first();
                      },
                    ));
                  });
                },
                child: Text("Update")),
          )
        ],
      ),
    );
  }
}
