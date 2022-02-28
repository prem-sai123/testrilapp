import 'package:meta/meta.dart';

import '../../list_view/data/transactiontype.dart';

class GateEntry {
  final String? id;
  final String? documentNo;
  final TransactionType? transactionType;
  final String? driverName;
  final String? date;
  final String? additionalField;
  final String? org;

  GateEntry({
    @required this.id,
    @required this.documentNo,
    @required this.transactionType,
    @required this.driverName,
    @required this.date,
    @required this.additionalField,
    this.org,
  });

  factory GateEntry.fromJson(Map<String, dynamic> json) {
    var additionalFieldValue = "";
    final transactionType =
        TransactionTypeExtenstion.fromName(json['transactiontype']);
    switch (transactionType) {
      case TransactionType.RawMaterial:
        additionalFieldValue = json['bpartner\$_identifier'];
        break;
      case TransactionType.Spares:
        additionalFieldValue = json['serviceprovider\$_identifier'];
        break;
      case TransactionType.Machines:
        additionalFieldValue = json['customer\$_identifier'];
        break;
      case TransactionType.DeliveryChallan:
        additionalFieldValue = json['personname'];
        break;
    }

    return GateEntry(
        id: json['id'],
        documentNo: json['documentNo'],
        transactionType: transactionType,
        driverName: json['drivername'] ?? '',
        date: json['creationDate'],
        additionalField: additionalFieldValue ?? '',
        org: json['organization\$_identifier']);
  }
}
