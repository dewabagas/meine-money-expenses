class Expense {
  final String name;
  final String category;
  final String date;
  final int amount;

  Expense({
    required this.name,
    required this.category,
    required this.date,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'date': date,
      'amount': amount,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      name: map['name'],
      category: map['category'],
      date: map['date'],
      amount: map['amount'],
    );
  }

  DateTime get dateAsDateTime {
    return DateTime.parse(date);
  }
}
