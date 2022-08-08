import 'package:flutter/material.dart';
import 'package:notes/DBHelper.dart';
import 'package:notes/main.dart';
import 'package:notes/model.dart';

import 'package:sqflite/sqflite.dart';

class second extends StatefulWidget {
  Map? s;

  second({this.s});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  TextEditingController t = TextEditingController(text: "");
  TextEditingController t1 = TextEditingController(text: "");
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBhelper().opendb().then((value) {
      db = value;
      t.text = '${widget.s!['title']}';
      t1.text = '${widget.s!['subtitle']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton  (
                  onPressed: () async {
                    String title = t.text;
                    String subtitle = t1.text;
                    String qry =
                        "insert into notes (title,subtitle) values ('$title','$subtitle')";
                    await db!.rawInsert(qry).then((value) {
                      print(value);
                    });

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return first();
                      },
                    ));
                  },
                  icon: Icon(Icons.save))
            ],
          ),
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

            ],
          ),
        ),
        onWillPop: onback);
  }

  Future<bool> onback() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => first(),
        ));
    return Future.value();
  }
}
