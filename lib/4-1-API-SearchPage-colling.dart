import 'dart:convert';
import 'package:flutter/material.dart';
import '4-2-API-HOME-SeeAll-CategoriesPage.dart';
import '4-3-API-Products-Gridview-coll.dart';
import '4-4-API-See-all-Categoriey.dart';
import 'package:http/http.dart' as http;

class ApiSearchPage1 extends StatefulWidget {
  const ApiSearchPage1({Key? key}) : super(key: key);

  @override
  State<ApiSearchPage1> createState() => _ApiSearchPage1State();
}

class _ApiSearchPage1State extends State<ApiSearchPage1> {
  TextEditingController demo = TextEditingController();
  var Data;
  bool isSearching = false;
  bool lodding = false;
  Future getdata() async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/search?q=${demo.text}"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSearching) {
          isSearching = false;
          setState(() {});
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    onTap: () {
                      isSearching = true;
                      setState(() {});
                    },
                    controller: demo,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          getdata();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      filled: true,
                      fillColor: Colors.black12.withAlpha(15),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                isSearching
                    ? Data != null
                        ? lodding
                            ? CircularProgressIndicator()
                            : GridView.builder(
                                itemCount: Data["products"].length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2 / 2.9),
                                shrinkWrap: true,
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
                                                  code: Data["products"][index]
                                                      ["id"],
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
                                            Data["products"][index]
                                                ["thumbnail"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${Data["products"][index]["title"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  );
                                },
                              )
                        : const Center(
                            child: Text('No Data'),
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 310),
                            child: InkResponse(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const seeall(),
                                    ),
                                  );
                                });
                              },
                              child: const Text(
                                "See all",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const ApiSeellHomePage(),
                          const SizedBox(
                            height: 10,
                          ),
                          const ApiGridviewcoll(),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
