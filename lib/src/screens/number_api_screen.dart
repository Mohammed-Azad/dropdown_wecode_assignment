import 'package:flutter/material.dart';

import '../service/Number_service.dart';

class Number extends StatelessWidget {
  const Number({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  TextEditingController _numcontrol = TextEditingController();
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
        Container(
          height: 100,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _numcontrol,
                  decoration: InputDecoration(
                    hintText: "Input Number ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Container(
                  height: 65,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.search),
                      label: Text("Search"))),
            ],
          ),
        ),
        _numcontrol.value.text == ''
            ? Container(
                child: Text(" "),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: FutureBuilder<String>(
                      future: srvice.fechNumber(_numcontrol.value.text == ''
                          ? '0'
                          : _numcontrol.value.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("...Loading"),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else if (snapshot.data == null) {
                          return Text("No Data");
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: 350,
                                  height: 200,
                                  child: Text("${snapshot.data}"),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ),
      ],
    );
  }
}
