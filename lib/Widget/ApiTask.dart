import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class RtoTask extends StatefulWidget {
  const RtoTask({super.key});

  @override
  State<RtoTask> createState() => _RtoTaskState();
}

class _RtoTaskState extends State<RtoTask> {
  dynamic responseData;

  Future<Map> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://rbrgloblesolution.in/RTOInformation/rtoinformation.php'));

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
    } else {
      log('ERROR---------->>>>>>>>>>${response.statusCode}');
    }
    return responseData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data!['tag_rto_info'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data['tag_rto_info'][index]['name']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            data['tag_rto_info'][index]['rtoList'].length,
                        itemBuilder: (context, innerIndex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text('Id'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['id']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('rto_code'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['rto_code']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('district'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['district']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('state'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['state']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('address'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['address']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('phone'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['phone']}',
                                ),
                              ),
                              ListTile(
                                title: const Text('website'),
                                subtitle: Text(
                                  '${data['tag_rto_info'][index]['rtoList'][innerIndex]['website']}',
                                ),
                              ),
                              Divider(thickness: 3, color: Colors.red.shade300),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
