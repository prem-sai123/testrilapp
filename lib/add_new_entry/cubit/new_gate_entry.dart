import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testrilapp/dashboard/domain/model/transactiontype.dart';

class SaveRecod {
  bool status = false;
  Future<bool> saveRecord(String driverName, String? transactionType) async {
    try {
      const String url =
          'https://testril.easycloud.in/testril/org.openbravo.service.json.jsonrest/mbcrm_gateentry?l=Janya&p=rahul';
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "data": {
              "drivername": driverName,
              "customer": "C819993AFEA34C79BAD6A3B9656B0574",
              "transactiontype": transactionType
            }
          },
        ),
      );
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        if (body['response']['status'] == 0) {
          status = true;
          return status;
        }
        return status = false;
      }
    } catch (err, stack) {
      print('{$err,$stack}');
      status = false;
      return false;
    }
    return status;
  }
}
