import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '0-Model-Responce-use.dart';
import '0-Model-categoryuse.dart';
import '2-StreamBuilder.dart';
import '3-2-API-GetdataColl.dart';
import '3-3-Api-Colling-Page.dart';
import '3-5-API-WithautFutureBuilder.dart';
import '4-1-API-SearchPage-colling.dart';
import '5-Search-TextField-Data.dart';
import '6-1-POST-Api.dart';
import '6-2-Post-TextFeild.dart';
import 'View/HomeScreen/home_Screen-2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiSearchPage1(),
    );
  }
}
