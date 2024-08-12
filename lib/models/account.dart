class Account {
  final int? id;
  final String name;
  final int bankId;
  final int currencyId;
  final int accountTypeId;

  Account({
    this.id,
    required this.name,
    required this.bankId,
    required this.currencyId,
    required this.accountTypeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bank_id': bankId,
      'currency_id': currencyId,
      'account_type_id': accountTypeId,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      bankId: map['bank_id'],
      currencyId: map['currency_id'],
      accountTypeId: map['account_type_id'],
    );
  }

  Account copyWith({
    int? id,
    String? name,
    int? bankId,
    int? currencyId,
    int? accountTypeId,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      bankId: bankId ?? this.bankId,
      currencyId: currencyId ?? this.currencyId,
      accountTypeId: accountTypeId ?? this.accountTypeId,
    );
  }
}
