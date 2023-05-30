import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '4-3-API-Products-Gridview-coll.dart';
import 'Api/Api-Routeds/dart-file.dart';
import 'Model/Response/product_response_model.dart';

class SearchTextFeildresponse extends StatefulWidget {
  const SearchTextFeildresponse({Key? key}) : super(key: key);

  @override
  State<SearchTextFeildresponse> createState() =>
      _SearchTextFeildresponseState();
}

class _SearchTextFeildresponseState extends State<SearchTextFeildresponse> {
  TextEditingController demo = TextEditingController();
  bool lodding = false;
  bool isSrching = false;
  var Data;
  ProductResponseModel? productResponseModel;
  Future<ProductResponseModel> getdata() async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http.get(
      Uri.parse("${ApiRoutes.search}${demo.text}"),
    );
    if (response.statusCode == 200) {
      productResponseModel = productResponseModelFromJson(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
    return productResponseModel!;
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
        if (isSrching) {
          isSrching = false;
          setState(() {});
          return Future(
            () => false,
          );
        } else {
          return Future(
            () => true,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: demo,
                  onTap: () {
                    setState(() {
                      isSrching = true;
                      setState(() {});
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        getdata();
                      },
                      icon: Icon(Icons.search),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  ),
                ),
              ),
              isSrching
                  ? Data != null
                      ? lodding
                          ? CircularProgressIndicator()
                          : GridView.builder(
                              itemCount: 30,
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
                                        productResponseModel!
                                            .products[index].thumbnail,

                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "${productResponseModel!.products[index].title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                );
                              },
                            )
                      : Text("no data")
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
      ),
    );
  }
}
