import 'package:flutter/material.dart';

class StreambuilderTack extends StatefulWidget {
  const StreambuilderTack({Key? key}) : super(key: key);

  @override
  State<StreambuilderTack> createState() => _StreambuilderTackState();
}

class _StreambuilderTackState extends State<StreambuilderTack> {
  var home = GlobalKey<FormState>();
  TextEditingController one = TextEditingController();
  List<String> namelist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: home,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 260,
                    child: TextFormField(
                      controller: one,
                      decoration: InputDecoration(
                        hintText: "ENTER NAME",
                        prefixIcon: Icon(
                          Icons.save,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        setState(() {});
                        if (value!.isEmpty) {
                          return "Place Enter Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkResponse(
                    onTap: () {
                      setState(() {});
                      if (home.currentState!.validate()) {
                        namelist.add(one.text);
                        one.clear();
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(Icons.arrow_forward_outlined),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: namelist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30,
                        width: double.infinity,
                        color: Colors.amberAccent.withAlpha(30),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "${namelist[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    namelist.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                child: Text("CLEAR"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
