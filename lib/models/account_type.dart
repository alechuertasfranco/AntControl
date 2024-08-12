class AccountType {
  final int? id;
  final String name;

  AccountType({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory AccountType.fromMap(Map<String, dynamic> map) {
    return AccountType(id: map['id'], name: map['name']);
  }
}
