import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiBackandcoll extends StatefulWidget {
  const ApiBackandcoll({Key? key}) : super(key: key);

  @override
  State<ApiBackandcoll> createState() => _ApiBackandcollState();
}

class _ApiBackandcollState extends State<ApiBackandcoll> {
  var data;
  Future<List> getdata() async {
    http.Response response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos",
      ),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return data;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HttpApiUriParameterWidget(
                            userId: snapshot.data![index]["userId"],
                            id: snapshot.data![index]["id"],
                            title: snapshot.data![index]["title"],
                            completed: snapshot.data![index]["completed"],
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 390,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${snapshot.data![index]["id"]}"),
                        Text("${snapshot.data![index]["title"]}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class HttpApiUriParameterWidget extends StatefulWidget {
  const HttpApiUriParameterWidget(
      {Key? key, this.userId, this.id, this.title, this.completed})
      : super(key: key);
  final userId;
  final id;
  final title;
  final completed;

  @override
  State<HttpApiUriParameterWidget> createState() =>
      _HttpApiUriParameterWidgetState();
}

class _HttpApiUriParameterWidgetState extends State<HttpApiUriParameterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.green.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.userId}"),
            Text("${widget.id}"),
            Text("${widget.title}"),
            Text("${widget.completed}"),
          ],
        ),
      )),
    );
  }
}
