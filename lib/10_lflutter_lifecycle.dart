// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'Constant/Comon_button.dart';
//
// class HomeScreen3 extends StatefulWidget {
//   const HomeScreen3({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen3> createState() => _HomeScreen3State();
// }
//
// class _HomeScreen3State extends State<HomeScreen3> {
//   int counter = 0;
//
//   Future<int> getData() async {
//     await Future.delayed(Duration(seconds: 2));
//
//     return 10;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     log('hello');
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FutureBuilder(
//               future: getData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Text('${snapshot.data}');
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//             Text(
//               '${counter}',
//               style: TextStyle(fontSize: 50),
//             ),
//             commonbutton(
//               'register',
//               () {
//                 counter++;
//                 log('VALUE ${counter}');
//               },
//               65,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void didUpdateWidget(covariant HomeScreen3 oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
// }
//
// /////////////////////////////////////////////////
// /// @override
// /// void initState() {
// ///  TODO: implement initState
// ///   super.initState();
// /// }
// ///@override
// ///void didChangeDependencies() {
// ///TODO: implement didChangeDependencies
// ///  super.didChangeDependencies();
// /// }
// /// Widget build(BuildContext context)
// ///
// ///@override
// ///void didUpdateWidget(covariant HomeScreen3 oldWidget) {
// /// TODO: implement didUpdateWidget
// /// super.didUpdateWidget(oldWidget);
// /// }
//
// ///  @override
// /// void dispose() {
// ///  TODO: implement dispose
// ///   super.dispose();
// ///  }
