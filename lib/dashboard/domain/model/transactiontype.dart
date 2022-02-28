enum TransactionType { RawMaterial, Spares, Machines, DeliveryChallan }
extension TransactionTypeExtenstion on TransactionType {
  static const _typeToName = {
    TransactionType.RawMaterial: 'Raw Material',
    TransactionType.Spares: 'Spares',
    TransactionType.Machines: 'Machines',
    TransactionType.DeliveryChallan: 'Delivery Challan'
  };

  static const _nameToType = {
    'Raw Material': TransactionType.RawMaterial,
    'Spares': TransactionType.Spares,
    'Machines': TransactionType.Machines,
    'Delivery Challan': TransactionType.DeliveryChallan
  };

  static TransactionType? fromName(String name) {
    return _nameToType[name];
  }

  static String? toName(TransactionType type) {
    return _typeToName[type];
  }
}