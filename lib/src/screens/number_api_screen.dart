import 'package:flutter/material.dart';

import '../service/Number_service.dart';

class Number extends StatelessWidget {
  const Number({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: numberScreen(),
      ),
    );
  }
}

class numberScreen extends StatefulWidget {
  numberScreen({Key? key}) : super(key: key);

  @override
  State<numberScreen> createState() => _numberScreenState();
}

class _numberScreenState extends State<numberScreen> {
  Numberservice srvice = new Numberservice();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Numbers",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 400,
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Number Input",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: 350,
              height: 200,
              child: Text("here the content"),
            ),
          ],
        ),
      ],
    );
  }
}
