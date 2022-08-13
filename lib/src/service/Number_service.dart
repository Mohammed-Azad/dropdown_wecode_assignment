import 'package:http/http.dart' as http;
import 'package:dropdown_wecode_assignment/src/screens/number_api_screen.dart';

class Numberservice {
  
  Future<String> fechNumber(String number) async {
    Uri _NumberApi = Uri.parse("http://numberapi.com/$number");
    http.Response _getApi =
        await http.get(_NumberApi).catchError((err) => print("$err"));
    return _getApi.body;
  }
}
