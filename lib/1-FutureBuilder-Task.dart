import 'package:flutter/material.dart';

class FututrTack extends StatefulWidget {
  const FututrTack({Key? key}) : super(key: key);

  @override
  State<FututrTack> createState() => _FututrTackState();
}

class _FututrTackState extends State<FututrTack> {
  Future<List> Futuretack() async {
    await Future.delayed(Duration(seconds: 1));
    return Data;
  }

  List<Map<String, dynamic>> Data = [
    {
      "No": "1",
      "Name": "Viraj",
      "Age": "20",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "Puna Gam",
      "Society": "Dayaram"
    },
    {
      "No": "2",
      "Name": "JaydeepBhai",
      "Age": "26",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "MOta Varaccha",
      "Society": "ShivNagar"
    },
    {
      "No": "3",
      "Name": "Nikunj",
      "Age": "21",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "Kapodra",
      "Society": "Santosh Nagar"
    },
    {
      "No": "4",
      "Name": "Vishal",
      "Age": "22",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "Puna Gam",
      "Society": "Ayodhya"
    },
    {
      "No": "5",
      "Name": "Yash",
      "Age": "20",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "Vraj Chowk",
      "Society": "Manya"
    },
    {
      "No": "6",
      "Name": "Mahesh",
      "Age": "28",
      "State": "Gujarat",
      "City": "Surat",
      "Area": "Sarthana",
      "Society": "Sant Devidas"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
          future: Futuretack(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 390,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.deepOrangeAccent.shade100,
                    child: Column(
                      children: [
                        Text("Number: ${snapshot.data![index]["No"]}"),
                        Text("Name: ${snapshot.data![index]["Name"]}"),
                        Text("AGe: ${snapshot.data![index]["Age"]}"),
                        Text("State: ${snapshot.data![index]["State"]}"),
                        Text("City: ${snapshot.data![index]["City"]}"),
                        Text("Area: ${snapshot.data![index]["Area"]}"),
                        Text("Society: ${snapshot.data![index]["Society"]}"),
                      ],
                    ),
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
