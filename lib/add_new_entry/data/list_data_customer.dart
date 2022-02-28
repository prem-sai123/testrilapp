import 'dart:convert';
import 'package:http/http.dart';
import 'package:testrilapp/add_new_entry/domain/model/customerdata.dart';

class FetchCustomerData {
  Future<List<BusinessPartner>> fetchCustomerData(
      String prefName, String prefPass) async {
    List<BusinessPartner> _resultList = [];
    try {
      final String _baseUrl =
          'https://testril.easycloud.in/testril/org.openbravo.service.json.jsonrest/BusinessPartner?l=$prefName&p=$prefPass&_sortBy=name&_endRow=10';
      var _urlRes = await get(Uri.parse(_baseUrl));
      if (_urlRes.statusCode == 200) {
        var data = jsonDecode(_urlRes.body) as Map<String, dynamic>;
        var resData = data['response'];
        for (var entry in resData['data']) {
          BusinessPartner _gateEntryRes = BusinessPartner.fromJson(entry);
          _resultList.add(_gateEntryRes);
        }
      } else {
        _resultList;
      }
      return _resultList;
    } catch (err, stack) {
      print('{$err,$stack}');
      return _resultList;
    }
  }
}
