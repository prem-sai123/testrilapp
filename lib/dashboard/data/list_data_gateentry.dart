import 'dart:convert';

import 'package:testrilapp/dashboard/domain/gateentry.dart';
import 'package:http/http.dart';

class FetchedGateEntryData {
  Future<List<GateEntry>> fetchedGateEntryData(
      String prefName, String prefPass) async {
    List<GateEntry> _resultList = [];
    try {
      final String _baseUrl =
          'https://testril.easycloud.in/testril/org.openbravo.service.json.jsonrest/mbcrm_gateentry?l=$prefName&p=$prefPass&_endRow=25&_sortBy=creationDate%20desc';
      var _urlRes = await get(Uri.parse(_baseUrl));
      if (_urlRes.statusCode == 200) {
        var data = jsonDecode(_urlRes.body) as Map<String, dynamic>;
        var resData = data['response'];
        for (var entry in resData['data']) {
          GateEntry _gateEntryRes = GateEntry.fromJson(entry);
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
