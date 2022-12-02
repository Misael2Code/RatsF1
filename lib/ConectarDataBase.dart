import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Test",
      home: ConectarDataBase(),
    );
  }
}

class ConectarDataBase extends StatefulWidget {
  const ConectarDataBase({Key? key}) : super(key: key);

  @override
  _ConectarDataBaseState createState() => _ConectarDataBaseState();
}

class _ConectarDataBaseState extends State<ConectarDataBase> {
  Future<void> connect(BuildContext ctx) async {
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("LOADING"),
            content: CircularProgressIndicator(),
          );
        },
      );
      await SqlConn.connect(
          ip: "51.79.107.121",
          port: "1433",
          databaseName: "gestorf1",
          username: "gestorf1",
          password: "F1\$#@!56789");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => connect(context),
                  child: const Text("Connect")),
              ElevatedButton(
                  onPressed: () => read("SELECT * FROM IP_List"),
                  child: const Text("Read")),
              ElevatedButton(
                  onPressed: () => write("DELETE FROM IP_List WHERE LOC='vv1'"),
                  child: const Text("Write")),
              ElevatedButton(
                  onPressed: () => write(
                      "CREATE TABLE Persons (PersonID int, LastName varchar(255), FirstName varchar(255), Address varchar(255),City varchar(255))"),
                  child: const Text("Create Table")),
              ElevatedButton(
                  onPressed: () => write(
                      "DROP TABLE Persons"),
                  child: const Text("Delete Table")),
              ElevatedButton(
                  onPressed: () => SqlConn.disconnect(),
                  child: const Text("Disconnect"))
            ],
          ),
        ));
  }
}