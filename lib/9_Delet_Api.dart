import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeletApi extends StatefulWidget {
  const DeletApi({Key? key}) : super(key: key);

  @override
  State<DeletApi> createState() => _DeletApiState();
}

class _DeletApiState extends State<DeletApi> {
  var body = {"title": "Nikuj", "stock": "jaydeep"};
  bool lodding = false;
  var data;
  Future getdata(tital) async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http.delete(
      Uri.parse('https://dummyjson.com/products/1'),
    );
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
                  color: Colors.green.shade100,
                  child: Center(
                    child: Text("Enter"),
                  ),
                ),
              ),
      ),
    );
  }
}
