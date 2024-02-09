// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:users_api_logo/models.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;
  List usersdata = [];
  String aaa = "";
  List<Userss> employedata = [];
  // ignore: body_might_complete_normally_nullable
  Future<List<Userss>?> fetchData() async {
    final fetchedData =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    // ignore: avoid_print
    print(fetchedData.body.toString());
    if (fetchedData.statusCode == 200) {
      var myjson = jsonDecode(fetchedData.body) as List;
      employedata = myjson.map((e) {
        return Userss.fromJson(e);
      }).toList();
      return employedata;
    } else {
      // ignore: avoid_print
      print("Fetching failed");
    }
  }

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<Userss>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Userss s = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: const Border(
                        left: BorderSide(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '${s.name}',
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            '${s.email}',
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            '${s.phone}',
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            '${s.address!.city},${s.address!.street},${s.address!.geo!.lat},${s.address!.geo!.lng}',
                            textScaleFactor: 1.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
