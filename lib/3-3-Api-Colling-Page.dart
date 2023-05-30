import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiColl extends StatefulWidget {
  const ApiColl({Key? key}) : super(key: key);

  @override
  State<ApiColl> createState() => _ApiCollState();
}

class _ApiCollState extends State<ApiColl> {
  var record;
  Future<List> getdata() async {
    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      record = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return record;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 390,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.deepOrangeAccent.shade100,
                    child: InkResponse(
                      onTap: () {
                        setState(() {
                          record = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApiPage2(
                                id: snapshot.data![index]["id"],
                              ),
                            ),
                          );
                        });
                      },
                      child: Column(
                        children: [
                          Text("${snapshot.data![index]["id"]}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("wrong");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class ApiPage2 extends StatefulWidget {
  const ApiPage2({
    Key? key,
    this.id,
  }) : super(key: key);
  final id;

  @override
  State<ApiPage2> createState() => _ApiPage2State();
}

class _ApiPage2State extends State<ApiPage2> {
  var data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/${widget.id}'),
    );
    if (response1.statusCode == 200) {
      print("${response1.body}");
      data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return data1;
  }

  @override
  void initState() {
    super.initState();
    getdata1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map>(
          future: getdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                height: 200,
                width: 390,
                color: Colors.blue.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${snapshot.data!["userId"]}"),
                    Text("${snapshot.data!["id"]}"),
                    Text("${snapshot.data!["title"]}"),
                    Text("${snapshot.data!["completed"]}"),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("wrong");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
