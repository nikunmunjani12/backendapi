import 'package:flutter/material.dart';

class FutureBuilder1 extends StatefulWidget {
  const FutureBuilder1({Key? key}) : super(key: key);

  @override
  State<FutureBuilder1> createState() => _FutureBuilder1State();
}

class _FutureBuilder1State extends State<FutureBuilder1> {
  Future futuree() async {
    await Future.delayed(Duration(seconds: 5));
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futuree(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text("${snapshot.data}");
            } else if (snapshot.hasError) {
              return Text(
                "wrong",
                style: TextStyle(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
