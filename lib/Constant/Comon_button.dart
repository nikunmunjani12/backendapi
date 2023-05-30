import 'package:backendapi/Constant/Text-style.dart';
import 'package:flutter/material.dart';

GestureDetector commonbutton(String title, Function() onTap, double height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: kGreen20w800,
        ),
      ),
    ),
  );
}
