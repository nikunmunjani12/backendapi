import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PestApi extends StatefulWidget {
  const PestApi({Key? key}) : super(key: key);

  @override
  State<PestApi> createState() => _PestApiState();
}

class _PestApiState extends State<PestApi> {
  var body = {"title": "Nikuj", "stock": "jaydeep"};
  bool lodding = false;
  var data;
  Future getdata(title) async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http
        .patch(Uri.parse('https://dummyjson.com/products/1'), body: title);
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
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
                  color: Colors.red.shade100,
                  child: Center(
                    child: Text("Enter"),
                  ),
                ),
              ),
      ),
    );
  }
}
