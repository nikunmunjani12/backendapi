import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithautFuture extends StatefulWidget {
  const WithautFuture({Key? key}) : super(key: key);

  @override
  State<WithautFuture> createState() => _WithautFutureState();
}

class _WithautFutureState extends State<WithautFuture> {
  bool lodding = false;
  var Data;
  Future getdata() async {
    setState(() {
      lodding = true;
    });
    // lodding = true;
    http.Response response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos",
      ),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
    return Data;
    // lodding = false;
  }

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lodding == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: Data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 390,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: Colors.blueGrey,
                  child: Center(
                      child: Column(
                    children: [
                      Text("${Data[index]['userId']}"),
                      Text("${Data[index]['id']}"),
                      Text("${Data[index]['title']}"),
                      Text("${Data[index]['completed']}"),
                    ],
                  )),
                );
              },
            ),
    );
  }
}
