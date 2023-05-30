// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '4-3-API-Products-Gridview-coll.dart';
//
// class SearchTextFeild extends StatefulWidget {
//   const SearchTextFeild({Key? key}) : super(key: key);
//
//   @override
//   State<SearchTextFeild> createState() => _SearchTextFeildState();
// }
//
// class _SearchTextFeildState extends State<SearchTextFeild> {
//   bool lodding = false;
//   bool isChersing = false;
//   var Data;
//   TextEditingController onr = TextEditingController();
//   Future getdata() async {
//     setState(() {
//       lodding = true;
//     });
//     http.Response response = await http.get(
//       Uri.parse("https://dummyjson.com/products/search?q=${onr.text}"),
//     );
//     if (response.statusCode == 200) {
//       print("${response.body}");
//       Data = jsonDecode(response.body);
//     } else {
//       print("${response.statusCode}");
//     }
//     setState(() {
//       lodding = false;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         if (isChersing) {
//           isChersing = false;
//           setState(() {});
//           return Future(() => false);
//         } else {
//           return Future(() => true);
//         }
//       },
//       child: Scaffold(
//         body: Center(
//           child: Column(children: [
//             SizedBox(
//               height: 100,
//             ),
//             TextField(
//               onTap: () {
//                 isChersing = true;
//                 setState(() {});
//               },
//               controller: onr,
//               decoration: InputDecoration(
//                   hintText: "search",
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       getdata();
//                     },
//                     icon: Icon(Icons.search),
//                   )),
//             ),
//             isChersing
//                 ? Data != null
//                     ? lodding
//                         ? CircularProgressIndicator()
//                         : GridView.builder(
//                             itemCount: Data["products"].length,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     childAspectRatio: 2 / 2.9),
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 children: [
//                                   Container(
//                                     height: 220,
//                                     width: 180,
//                                     margin: EdgeInsets.symmetric(
//                                         horizontal: 5, vertical: 5),
//                                     child: Image.network(
//                                       Data["products"][index]["thumbnail"],
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   Text(
//                                     "${Data["products"][index]["title"]}",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                   ),
//                                 ],
//                               );
//                             },
//                           )
//                     : Text("no data")
//                 : Column(
//                     children: [
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ApiGridviewcoll(),
//                     ],
//                   ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '4-3-API-Products-Gridview-coll.dart';

class SearchTextFeild extends StatefulWidget {
  const SearchTextFeild({Key? key}) : super(key: key);

  @override
  State<SearchTextFeild> createState() => _SearchTextFeildState();
}

class _SearchTextFeildState extends State<SearchTextFeild> {
  TextEditingController one = TextEditingController();
  bool isSrsing = false;
  bool lodding = false;
  var data;
  Future getdata() async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http.get(
      Uri.parse('https://dummyjson.com/products/search?q=${one.text}'),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
      data = jsonDecode(response.body);
    } else {
      print('${response.statusCode}');
    }
    setState(() {
      lodding = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSrsing) {
          isSrsing = false;
          setState(() {});
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextField(
              controller: one,
              onTap: () {
                isSrsing = true;
                setState(() {});
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    getdata();
                  },
                  icon: Icon(Icons.abc),
                ),
              ),
            ),
            isSrsing
                ? data != null
                    ? lodding
                        ? CircularProgressIndicator()
                        : GridView.builder(
                            itemCount: data["products"].length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.9),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 220,
                                    width: 180,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Image.network(
                                      data["products"][index]["thumbnail"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "${data["products"][index]["title"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              );
                            },
                          )
                    : Text('no data')
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ApiGridviewcoll(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
