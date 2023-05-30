import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutApi extends StatefulWidget {
  const PutApi({Key? key}) : super(key: key);

  @override
  State<PutApi> createState() => _PutApiState();
}

class _PutApiState extends State<PutApi> {
  var body = {"title": "Nikuj", "price": "deep", "stock": "jaydeep"};
  var data;
  bool lodding = false;
  Future getdata(title) async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http
        .put(Uri.parse('https://dummyjson.com/products/1'), body: title);
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
