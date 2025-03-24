// نموذج بيانات الفاتورة
class Receipt {
  final String merchant;
  final DateTime date;
  final double amount;

  Receipt({required this.merchant, required this.date, required this.amount});

  // إنشاء كائن Receipt من JSON
  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      merchant: json['merchant'] ?? 'غير معروف',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }

  // تحويل Receipt إلى JSON (إن أردت تخزينه محليًا)
  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}
