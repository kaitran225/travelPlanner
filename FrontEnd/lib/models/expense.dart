class Expense {
  String id;
  String tripId;
  String title;
  String description;
  double amount;
  DateTime date;
  String category;
  String currency;
  String receiptImageUrl;
  
  Expense({
    required this.id,
    required this.tripId,
    required this.title,
    this.description = '',
    required this.amount,
    required this.date,
    required this.category,
    required this.currency,
    this.receiptImageUrl = '',
  });
  
  // Factory constructor to create Expense from JSON
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      tripId: json['tripId'],
      title: json['title'],
      description: json['description'] ?? '',
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      currency: json['currency'],
      receiptImageUrl: json['receiptImageUrl'] ?? '',
    );
  }
  
  // Convert Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'currency': currency,
      'receiptImageUrl': receiptImageUrl,
    };
  }
  
  // Create a copy of the expense with given fields replaced with new values
  Expense copyWith({
    String? id,
    String? tripId,
    String? title,
    String? description,
    double? amount,
    DateTime? date,
    String? category,
    String? currency,
    String? receiptImageUrl,
  }) {
    return Expense(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      receiptImageUrl: receiptImageUrl ?? this.receiptImageUrl,
    );
  }
} 