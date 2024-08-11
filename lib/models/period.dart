class Period {
  final int? id;
  final int year;
  final int month;
  final String? formatted;

  Period({this.id, required this.year, required this.month, this.formatted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'month': month,
      'formatted': formatted,
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      id: map['id'],
      year: map['year'],
      month: map['month'],
      formatted: map['formatted'],
    );
  }
}
