import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/DBHelper.dart';
import 'package:notes/model.dart';
import 'package:notes/secondpage.dart';
import 'package:notes/update.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  Database? db;
  List<Map> list = [];
  bool b = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBhelper().opendb().then((value) {
      db = value;
      getdata();
    });
  }

  getdata() async {
    String qry = "select * from notes";
    await db!.rawQuery(qry).then((value) {
      print(value);
      list = value;
      b = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: b
          ? ListView.separated(
              itemBuilder: (context, index) {
                Map map = list[index];
                print(map);

                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return second(
                          s: map,
                        );
                      },
                    ));
                  },
                  title: Text("${map["title"]}"),
                  subtitle: Text("${map["subtitle"]}"),
                  leading:  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return update(map);
                          },));
                        },
                        icon: Icon(Icons.edit)),
                  ),
                  trailing: Container(
                    child: IconButton(
                        onPressed: () {
                          String qry =
                              "delete from notes where id = ${map['id']}";
                          db!.rawDelete(qry).then((value) {
                            print("delete");
                            getdata();
                          });
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  height: 10,
                );
              },
              itemCount: list.length)
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => second(),
              ));
        },
        elevation: 10,
        child: Icon(Icons.add),
      ),
    );
  }
}
