class Budget {
  final String id;
  final double total;
  double spent;
  final List<BudgetCategory> categories;

  Budget({
    required this.id,
    required this.total,
    this.spent = 0.0,
    required this.categories,
  });
  
  // Factory constructor to create Budget from JSON
  factory Budget.fromJson(Map<String, dynamic> json) {
    List<BudgetCategory> categoryList = [];
    
    if (json['categories'] != null) {
      categoryList = (json['categories'] as List)
          .map((category) => BudgetCategory.fromJson(category))
          .toList();
    }
    
    return Budget(
      id: json['id'],
      total: json['total'].toDouble(),
      spent: json['spent']?.toDouble() ?? 0.0,
      categories: categoryList,
    );
  }
  
  // Convert Budget to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'spent': spent,
      'categories': categories.map((category) => category.toJson()).toList(),
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
    double? total,
    double? spent,
    List<BudgetCategory>? categories,
  }) {
    return Budget(
      id: id ?? this.id,
      total: total ?? this.total,
      spent: spent ?? this.spent,
      categories: categories ?? List.from(this.categories),
    );
  }
}

class BudgetCategory {
  final String id;
  final String name;
  final double budgeted;
  double spent;

  BudgetCategory({
    required this.id,
    required this.name,
    required this.budgeted,
    this.spent = 0.0,
  });
  
  // Factory constructor to create BudgetCategory from JSON
  factory BudgetCategory.fromJson(Map<String, dynamic> json) {
    return BudgetCategory(
      id: json['id'],
      name: json['name'],
      budgeted: json['budgeted'].toDouble(),
      spent: json['spent']?.toDouble() ?? 0.0,
    );
  }
  
  // Convert BudgetCategory to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'budgeted': budgeted,
      'spent': spent,
    };
  }
  
  // Create a copy of the budget category with given fields replaced with new values
  BudgetCategory copyWith({
    String? id,
    String? name,
    double? budgeted,
    double? spent,
  }) {
    return BudgetCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      budgeted: budgeted ?? this.budgeted,
      spent: spent ?? this.spent,
    );
  }
} 