import 'package:flutter/material.dart';

import '../../Constant/Comon_button.dart';
import '../../Constant/commonList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          commonbutton("Enter", () {}, 50),
          productView()
        ],
      ),
    );
  }
}
