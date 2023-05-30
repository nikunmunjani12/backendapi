import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({Key? key}) : super(key: key);

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  var body = {"title": "Nikuj"};
  var data;
  bool lodding = false;
  Future getdata(title) async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http
        .post(Uri.parse('https://dummyjson.com/products/add'), body: title);
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
    //return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: lodding == true
            ? CircularProgressIndicator()
            : InkResponse(
                onTap: () {
                  setState(() {
                    getdata(body);
                  });
                },
                child: Container(
                  height: 40,
                  width: 80,
                  color: Colors.blue,
                  child: Center(
                    child: Text("Enter"),
                  ),
                ),
              ),
      ),
    );
  }
}
