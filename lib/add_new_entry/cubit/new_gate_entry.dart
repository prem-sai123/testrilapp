import 'dart:convert';
import 'package:http/http.dart' as http;

class SaveRecod {
  bool status = false;
  Future<bool> saveRecord(String driverName, String? transactionType,String? bpartnerId) async {
    try {
      const String url =
          'https://testril.easycloud.in/testril/org.openbravo.service.json.jsonrest/mbcrm_gateentry?l=Janya&p=rahul';
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "data": {
              "drivername": driverName,
              "customer": bpartnerId,
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
