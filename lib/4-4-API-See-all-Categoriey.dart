import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '3-4-API-Images-Colling.dart';

class seeall extends StatefulWidget {
  const seeall({
    Key? key,
  }) : super(key: key);
  @override
  State<seeall> createState() => _seeallState();
}

class _seeallState extends State<seeall> {
  var Data;
  Future<List> getadata() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return Data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getadata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
          future: getadata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: List.generate(
                      20,
                      (index) => InkResponse(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Catogerycollings(
                                    one: snapshot.data![index]),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 135,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Center(
                            child: Text(
                              "${snapshot.data![index]}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("wrong");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
class Catogerycollings extends StatefulWidget {
  const Catogerycollings({Key? key, this.one}) : super(key: key);
  final one;
  @override
  State<Catogerycollings> createState() => _CatogerycollingsState();
}

class _CatogerycollingsState extends State<Catogerycollings> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${widget.one}'),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data1 = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return Data1;
  }

  @override
  void initState() {
    super.initState();
    getdata1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<Map>(
            future: getdata1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  itemCount: snapshot.data!["products"].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2.9),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FakeApi(
                                    code: snapshot.data!['products'][index]
                                        ['id'],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 180,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Image.network(
                              snapshot.data!['products'][index]["thumbnail"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "${snapshot.data!["products"][index]["title"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
