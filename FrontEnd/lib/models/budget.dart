class Budget {
  String id;
  String tripId;
  double total;
  double spent;
  Map<String, double> categoryLimits;
  String currency;
  
  Budget({
    required this.id,
    required this.tripId,
    required this.total,
    this.spent = 0.0,
    required this.categoryLimits,
    required this.currency,
  });
  
  // Factory constructor to create Budget from JSON
  factory Budget.fromJson(Map<String, dynamic> json) {
    Map<String, double> categoryLimits = {};
    
    if (json['categoryLimits'] != null) {
      json['categoryLimits'].forEach((key, value) {
        categoryLimits[key] = value.toDouble();
      });
    }
    
    return Budget(
      id: json['id'],
      tripId: json['tripId'],
      total: json['total'],
      spent: json['spent'] ?? 0.0,
      categoryLimits: categoryLimits,
      currency: json['currency'],
    );
  }
  
  // Convert Budget to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'total': total,
      'spent': spent,
      'categoryLimits': categoryLimits,
      'currency': currency,
    };
  }
  
  // Calculate remaining budget
  double get remaining {
    return total - spent;
  }
  
  // Calculate percentage of budget spent
  double get percentSpent {
    if (total == 0) return 0;
    return (spent / total) * 100;
  }
  
  // Check if over budget
  bool get isOverBudget {
    return spent > total;
  }
  
  // Create a copy of the budget with given fields replaced with new values
  Budget copyWith({
    String? id,
    String? tripId,
    double? total,
    double? spent,
    Map<String, double>? categoryLimits,
    String? currency,
  }) {
    return Budget(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      total: total ?? this.total,
      spent: spent ?? this.spent,
      categoryLimits: categoryLimits ?? Map.from(this.categoryLimits),
      currency: currency ?? this.currency,
    );
  }
} 