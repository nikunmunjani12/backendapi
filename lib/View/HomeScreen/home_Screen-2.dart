import 'package:backendapi/Constant/Comon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Counter_controller.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  var counter = 0;
  CounterController controller = Get.put(CounterController());

  Future<int> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text('${snapshot.data}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(height: 30),
          GetBuilder<CounterController>(
            builder: (controller) => Text(controller.counter.toString()),
          ),
          commonbutton(
            "Register",
            () {
              controller.increment();
              print('VAlUE${counter}');
            },
            60,
          ),
        ],
      ),
    );
  }
}
