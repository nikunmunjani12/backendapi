import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostTextfeld extends StatefulWidget {
  const PostTextfeld({Key? key}) : super(key: key);

  @override
  State<PostTextfeld> createState() => _PostTextfeldState();
}

class _PostTextfeldState extends State<PostTextfeld> {
  bool lodding = false;
  Future getData(title) async {
    var body = {"title": "$title"};
    setState(() {
      lodding = true;
    });
    http.Response response = await http
        .post(Uri.parse('https://dummyjson.com/products/add'), body: body);
    if (response.statusCode == 200) {
      print("${response.body}");
      // data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
    //return data;
  }

  TextEditingController one = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          lodding == true
              ? CircularProgressIndicator()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
                  child: TextField(
                    controller: one,
                    decoration: InputDecoration(
                      hintText: "Search",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
          MaterialButton(
            onPressed: () {
              setState(() {
                getData(one.text);
              });
            },
            child: Text("enter"),
          ),
        ],
      ),
    );
  }
}
