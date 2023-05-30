// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ApiPagecolling1 extends StatefulWidget {
//   const ApiPagecolling1({Key? key}) : super(key: key);
//
//   @override
//   State<ApiPagecolling1> createState() => _ApiPagecolling1State();
// }
//
// class _ApiPagecolling1State extends State<ApiPagecolling1> {
//   var data;
//   Future getdata() async {
//     http.Response response = await http.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/todos'),
//     );
//     if (response.statusCode == 200) {
//       print("${response.body}");
//       //data = jsonDecode(response.body);
//       //return data;
//     } else {
//       print("${response.statusCode}");
//     }
//   }
//
//   @override
//   void initState() {
//     getdata();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPagecolling1 extends StatefulWidget {
  const ApiPagecolling1({Key? key}) : super(key: key);

  @override
  State<ApiPagecolling1> createState() => _ApiPagecolling1State();
}

class _ApiPagecolling1State extends State<ApiPagecolling1> {
  var data;
  Future getdata() async {
    http.Response response = await http.get(
      Uri.parse('uri'),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
      data = jsonDecode(response.body);
    } else {
      print('${response.statusCode}');
    }
    return Text('${data}');
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
