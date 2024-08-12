class Bank {
  final int? id;
  final String name;

  Bank({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(id: map['id'], name: map['name']);
  }
}
