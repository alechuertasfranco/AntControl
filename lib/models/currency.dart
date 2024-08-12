class Currency {
  final int? id;
  final String name;
  final String symbol;

  Currency({this.id, required this.name, required this.symbol});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'symbol': symbol};
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(id: map['id'], name: map['name'], symbol: map['symbol']);
  }
}
