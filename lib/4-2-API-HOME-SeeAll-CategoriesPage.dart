import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '3-4-API-Images-Colling.dart';

class ApiSeellHomePage extends StatefulWidget {
  const ApiSeellHomePage({Key? key}) : super(key: key);

  @override
  State<ApiSeellHomePage> createState() => _ApiSeellHomePageState();
}

class _ApiSeellHomePageState extends State<ApiSeellHomePage> {
  var Data;
  Future<List> getdata() async {
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
    getdata();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Center(
                      child: InkResponse(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home2Categoriey(
                                  send: snapshot.data![index],
                                ),
                              ),
                            );
                            selected = index;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 83,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected == index
                                    ? Colors.black
                                    : Colors.grey,
                                width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              "${snapshot.data![index]}",
                              style: TextStyle(
                                  color: selected == index
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class Home2Categoriey extends StatefulWidget {
  const Home2Categoriey({Key? key, this.send}) : super(key: key);
  final send;
  @override
  State<Home2Categoriey> createState() => _Home2CategorieyState();
}

class _Home2CategorieyState extends State<Home2Categoriey> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${widget.send}'),
    );
    if (response1.statusCode == 200) {
      print("${response1.body}");
      Data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return Data1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                                  code: snapshot.data!['products'][index]['id'],
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 220,
                          width: 180,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
    );
  }
}
