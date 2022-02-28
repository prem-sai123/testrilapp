import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserExists {
  bool _userCheck = false;
  Future<bool> fetchADUserData(String userName, String passWord) async {
    try {
      final String _testServerUrl =
          'https://testril.easycloud.in/testril/org.openbravo.service.json.jsonrest/ADUser?l=$userName&p=$passWord&where=username=$userName&_endRow=0';
      var response = await http.get(Uri.parse(_testServerUrl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _userCheck = true;
        SharedPreferences sharedPrefVar = await SharedPreferences.getInstance();
        sharedPrefVar.setString("isLoggedIn", _userCheck.toString());
      }
    } catch (err, stack) {
      print('$err,$stack');
    } finally {
      return _userCheck;
    }
  }
}
