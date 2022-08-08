 'package:database/database.dart';
import 'package:database/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}
class _secondState extends State<second> {
  TextEditingController tname=TextEditingController();
  TextEditingController tcontact=TextEditingController();
  Database? db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper().creatdatabase().then((value){
      db =value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("Contact book"),
      leading: IconButton(onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return first();
            },));
      }, icon: Icon(Icons.arrow_back)),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(5),
            child: TextField(
              controller: tname,
              decoration: const InputDecoration(
                  labelText: "Name",
                  border:OutlineInputBorder()
              ),
            ),),
          Padding(padding: const EdgeInsets.all(5),
            child: TextField(
              controller: tcontact,
              decoration: const InputDecoration(
                  labelText: "Number",
                  border:OutlineInputBorder()),
            ),),
          ElevatedButton(onPressed: ()async {
            String name =tname.text;
            String contact =tcontact.text;

            String qry = "insert into contactbook (name ,contact,fav) values('$name','$contact','0')";
            int x = await db!.rawInsert(qry);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return first();
            },));
          }, child: Text("Save"))
        ],
      ),
    ), onWillPop: goback);
  }
  Future<bool> goback(){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return first();
    },));
    return Future.value();
  }
}
