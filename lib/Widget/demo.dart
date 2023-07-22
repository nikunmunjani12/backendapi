import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DemoTask extends StatefulWidget {
  const DemoTask({super.key});

  @override
  State<DemoTask> createState() => _DemoTaskState();
}

class _DemoTaskState extends State<DemoTask> {
  var Data;
  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://www.foodchow.com/api/FoodChowWD/AllRestaurantsWDOfferApp?Country=India&city=Surat&area=&longitude=&latitude=&deliveryMethod=&cuisineId=2,1&clientid=&startlimit=0&endlimit=1000&onoffflag'));

    if (response.statusCode == 200) {
      print('${response.body}');
      Data = jsonDecode(response.body);
    } else {
      print('${response.statusCode}');
    }
    return Data;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text('${snapshot.data!['data'][index]['shop_id\n']}'),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
