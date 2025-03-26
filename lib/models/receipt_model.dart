class Receipt {
  final String merchant;
  final DateTime date;
  final double amount;

  Receipt({required this.merchant, required this.date, required this.amount});

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      merchant: json['merchant'] ?? 'غير معروف',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}
