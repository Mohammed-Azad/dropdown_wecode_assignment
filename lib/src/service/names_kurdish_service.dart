

import 'package:http/http.dart' as http;
import '../models/names_kurdish.dart';
import 'package:dropdown_wecode_assignment/src/screens/names_kurdish_list.dart';

class KurdishNamesService {
  String limit = "10";
  String gender = 'O';
  String sortby = 'positive';

  Future<NamesKurdish> fetchListOfNames() async {
    Uri _kurdishNamesUri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {
          'limit': limit,
          'gender': gender,
          'offset': "0",
          'sort': sortby,
        });

    // Uri _kurdishUri = Uri.parse(
    //       'https://nawikurdi.com/api?limit=$limit&gender=$gender&offset=0&sort=$sortby'); or another way in below
    http.Response _response =
        await http.get(_kurdishNamesUri).catchError((err) => print("$err"));
    NamesKurdish _kurdishNames = NamesKurdish.fromJson(_response.body);
    //print(_response.body);
    return _kurdishNames;
  }

  Future vote({required String nameId, required bool ispos}) async {
    String _impact = ispos == true ? "positive" : "negative";
    await http.post(Uri.parse("https://nawikurdi.com/api/vote"), body: {
      "name_id": nameId,
      "uid": "hello friend",
      "impact": _impact,
    });
  }
}
