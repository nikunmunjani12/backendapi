import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiImagescoll extends StatefulWidget {
  const ApiImagescoll({Key? key}) : super(key: key);

  @override
  State<ApiImagescoll> createState() => _ApiImagescollState();
}

class _ApiImagescollState extends State<ApiImagescoll> {
  var record;
  Future<Map> getdata() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://dummyjson.com/products',
      ),
    );
    if (response.statusCode == 200) {
      // print("${response.body}");
      record = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return record;
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map>(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: 30,
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
                                  code: snapshot.data!["products"][index]["id"],
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
                            snapshot.data!["products"][index]["thumbnail"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "${snapshot.data!["products"][index]["title"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "\$:${snapshot.data!["products"][index]["price"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  );
                },
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

class FakeApi extends StatefulWidget {
  const FakeApi({Key? key, this.code}) : super(key: key);
  final code;

  @override
  State<FakeApi> createState() => _FakeApiState();
}

class _FakeApiState extends State<FakeApi> {
  var data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://dummyjson.com/products/${widget.code}'),
    );
    if (response1.statusCode == 200) {
      print("${response1.body}");
      data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return data1;
  }

  @override
  void initState() {
    super.initState();
    getdata1();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map>(
          future: getdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        child: PageView.builder(
                          itemCount: snapshot.data!["images"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 400,
                              width: 390,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Image.network(
                                snapshot.data!['images'][index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data!["id"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["title"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["description"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["price"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["discountPercentage"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["rating"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["stock"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["brand"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["category"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  )
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
