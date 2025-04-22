import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import '../models/budget.dart';

class BudgetProvider extends ChangeNotifier {
  Map<String, Budget> _budgets = {}; // tripId -> Budget
  Map<String, List<Expense>> _expenses = {}; // tripId -> List<Expense>
  bool _isLoading = false;
  String? _error;
  
  // Getters
  Budget? getBudget(String tripId) => _budgets[tripId];
  List<Expense> getExpenses(String tripId) => [...(_expenses[tripId] ?? [])];
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Fetch budget for a specific trip
  Future<void> fetchBudget(String tripId) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return;
      }
      
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/budget'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final budgetData = json.decode(response.body);
        _budgets[tripId] = Budget.fromJson(budgetData);
        notifyListeners();
      } else {
        _setError('Failed to load budget');
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Fetch all expenses for a trip
  Future<void> fetchExpenses(String tripId) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return;
      }
      
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/expenses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> expensesData = json.decode(response.body);
        _expenses[tripId] = expensesData.map((e) => Expense.fromJson(e)).toList();
        notifyListeners();
      } else {
        _setError('Failed to load expenses');
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Create or update a budget for a trip
  Future<bool> saveBudget(String tripId, Budget budget) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return false;
      }
      
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/budget'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(budget.toJson()),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        _budgets[tripId] = Budget.fromJson(json.decode(response.body));
        notifyListeners();
        return true;
      } else {
        _setError('Failed to save budget');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Add an expense to a trip
  Future<bool> addExpense(String tripId, Expense expense) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return false;
      }
      
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/expenses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(expense.toJson()),
      );
      
      if (response.statusCode == 201) {
        final newExpense = Expense.fromJson(json.decode(response.body));
        if (_expenses[tripId] == null) {
          _expenses[tripId] = [];
        }
        _expenses[tripId]!.add(newExpense);
        
        // Update the remaining budget if it exists
        if (_budgets.containsKey(tripId)) {
          _budgets[tripId]!.spent += newExpense.amount;
        }
        
        notifyListeners();
        return true;
      } else {
        _setError('Failed to add expense');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Delete an expense
  Future<bool> deleteExpense(String tripId, String expenseId) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return false;
      }
      
      final response = await http.delete(
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/expenses/$expenseId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 204) {
        if (_expenses.containsKey(tripId)) {
          // Find the expense to update the budget accordingly
          final expense = _expenses[tripId]!.firstWhere((e) => e.id == expenseId);
          
          // Update remaining budget
          if (_budgets.containsKey(tripId)) {
            _budgets[tripId]!.spent -= expense.amount;
          }
          
          // Remove the expense from the list
          _expenses[tripId]!.removeWhere((e) => e.id == expenseId);
          
          notifyListeners();
        }
        return true;
      } else {
        _setError('Failed to delete expense');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Get spending by category
  Map<String, double> getSpendingByCategory(String tripId) {
    final expenses = _expenses[tripId] ?? [];
    final Map<String, double> result = {};
    
    for (var expense in expenses) {
      if (result.containsKey(expense.category)) {
        result[expense.category] = result[expense.category]! + expense.amount;
      } else {
        result[expense.category] = expense.amount;
      }
    }
    
    return result;
  }
  
  // Get percentage spent of total budget
  double getBudgetSpentPercentage(String tripId) {
    final budget = _budgets[tripId];
    if (budget == null || budget.total == 0) {
      return 0.0;
    }
    
    return (budget.spent / budget.total) * 100;
  }
  
  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }
} 