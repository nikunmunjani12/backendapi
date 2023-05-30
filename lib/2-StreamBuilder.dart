// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class StreamBuilder1 extends StatefulWidget {
//   const StreamBuilder1({Key? key}) : super(key: key);
//
//   @override
//   State<StreamBuilder1> createState() => _StreamBuilder1State();
// }
//
// class _StreamBuilder1State extends State<StreamBuilder1> {
//   StreamController<int> counter = StreamController();
//   int one = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               counter.sink.add(10);
//             });
//           },
//         ),
//         body: Center(
//           child: StreamBuilder<int>(
//             stream: counter.stream,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 one = one + snapshot.data!;
//                 return Text("${one}");
//               } else {
//                 return CircularProgressIndicator();
//               }
//             },
//           ),
//         ));
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilder1 extends StatefulWidget {
  const StreamBuilder1({Key? key}) : super(key: key);

  @override
  State<StreamBuilder1> createState() => _StreamBuilder1State();
}

class _StreamBuilder1State extends State<StreamBuilder1> {
  StreamController<int> counntr = StreamController();
  int data = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            counntr.sink.add(10);
          });
        }),
        body: Center(
            child: StreamBuilder<int>(
          stream: counntr.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = data + snapshot.data!;
              return Text('${data}');
            } else {
              return CircularProgressIndicator();
            }
          },
        )));
  }
}
