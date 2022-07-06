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
  final genderr = ['Female', 'Male'];
  String defgender = 'Male';
  var limitt = ["10", "20", "40", "60"];
  String deflimit = "10";
  var sortt = ['positive', 'negative'];
  String defsort = 'positive';
  var isPositive = true;
  @override
  Widget build(BuildContext context) {
    KurdishNamesService _namesService = KurdishNamesService();

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
                      color: Colors.indigo, fontWeight: FontWeight.bold,fontSize: 18),
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
                      }
                    });
                  }),
              // DropdownButton<String>(
              //   value: defsort,
              // items: sortt.map((String item) {
              //   return DropdownMenuItem<String>(
              //     child: Text(item),
              //   );
              // }).toList(),
              // onChanged: (newvalu) {
              //   setState(() {
              //     _namesService.sortby = newvalu!.toString();
                  
              //   });
              // }),

              DropdownButton(
                dropdownColor: Colors.grey[100],
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold,fontSize: 18),
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
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 50,
                          height: 50,
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
                                snapshot.data!.names[index].desc,
                                style: TextStyle(
                                  fontFamily: 'notosansArabic',
                                  fontSize: 14,
                                ),
                              )
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