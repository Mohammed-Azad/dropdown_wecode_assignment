import 'package:dropdown_wecode_assignment/src/service/names_kurdish_service.dart';
import 'package:dropdown_wecode_assignment/src/models/names_kurdish.dart';
import 'package:flutter/material.dart';

class KurdishNamesList extends StatelessWidget {
  KurdishNamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dropdown assignment",
          ),
          shadowColor: Colors.indigoAccent,
          backgroundColor: Colors.indigo,
          elevation: 10,
          centerTitle: true,
        ),
        body: DropdownList(),
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({Key? key}) : super(key: key);

  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  KurdishNamesService _namesService = KurdishNamesService();

  final genderr = ['Both', 'Female', 'Male'];
  String defgender = 'Both';
  var limitt = ["10", "20", "40", "60", "100", "250", "500"];
  String deflimit = "10";
  final sortt = ['positive', 'negative'];
  String defsort = 'positive';
  var isPositive = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                  dropdownColor: Colors.grey[100],
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  underline: Container(height: 3, color: Colors.indigo),
                  value: defgender,
                  items: genderr.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == 'Female') {
                        _namesService.gender = 'F';
                        defgender = "Female";
                      } else if (newValue == 'Male') {
                        _namesService.gender = 'M';
                        defgender = "Male";
                      } else {
                        _namesService.gender = 'O';
                        defgender = "Both";
                      }
                    });
                  }),
              DropdownButton<String>(
                  dropdownColor: Colors.grey[100],
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  underline: Container(height: 3, color: Colors.indigo),
                  hint: Text(
                    "SortBy",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  //value: defsort,
                  items: sortt.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (newvalu) {
                    setState(() {
                      _namesService.sortby = newvalu!;
                      isPositive = newvalu == 'negative' ? false : true;
                    });
                  }),
              SizedBox(
                width: 46,
                child: Text(
                  "Items:",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              DropdownButton(
                  dropdownColor: Colors.grey[100],
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  underline: Container(height: 3, color: Colors.indigo),
                  value: deflimit,
                  items: limitt.map((String? item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item!),
                    );
                  }).toList(),
                  onChanged: (newval) {
                    setState(() {
                      _namesService.limit = newval.toString();
                      deflimit = newval.toString();
                    });
                  }),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: FutureBuilder<NamesKurdish>(
                  future: _namesService.fetchListOfNames(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return Text("no data");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          Name _name = snapshot.data!.names[index];
                          return ExpansionTile(
                            title: Text(
                              snapshot.data!.names[index].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'notosansArabic',
                                  fontWeight: FontWeight.bold),
                            ),
                            children: [
                              Text(
                                _name.desc,
                                style: TextStyle(
                                  fontFamily: 'notosansArabic',
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    onPressed: () async{
                                      await _namesService.vote(
                                          nameId: _name.nameId.toString(),
                                          ispos:true).then((value) {
                                            setState(() {
                                              
                                            });
                                          });
                                    },
                                    icon: Icon(Icons.thumb_up_alt_sharp),
                                    label:
                                        Text(_name.positive_votes.toString()),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () async {
                                      await _namesService.vote(
                                          nameId: _name.nameId.toString(),
                                          ispos:false ).then((value) {
                                            setState(() {
                                              
                                            });
                                          });
                                    },
                                    icon: Icon(Icons.thumb_down_alt_sharp),
                                    label:
                                        Text(_name.negative_votes.toString()),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  }),
                )),
          ),
        ),
      ],
    );
  }
}
