import 'package:flutter/material.dart';

Expanded productView() {
  return Expanded(
    child: ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(10),
          color: Colors.teal,
        );
      },
    ),
  );
}
