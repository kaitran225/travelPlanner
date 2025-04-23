import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  String? _userId;
  String? _email;
  String? _userName;
  
  // Getters
  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  String? get userId => _userId;
  String? get email => _email;
  String? get userName => _userName;
  
  // Constructor to initialize with saved token
  AuthProvider() {
    _loadSavedToken();
  }
  
  // Load saved token from SharedPreferences
  Future<void> _loadSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');
    
    if (savedToken != null) {
      try {
        // Verify and decode token
        if (!JwtDecoder.isExpired(savedToken)) {
          final Map<String, dynamic> decodedToken = JwtDecoder.decode(savedToken);
          
          _token = savedToken;
          _isAuthenticated = true;
          _userId = decodedToken['sub'];
          _email = decodedToken['email'];
          _userName = decodedToken['name'];
          
          notifyListeners();
        } else {
          // Token expired, log out
          _logout();
        }
      } catch (e) {
        _logout();
      }
    }
  }
  
  // Login method
  Future<bool> login(String email, String password) async {
    try {
      // Bypass authentication for development
      if (email == 'john.doe@example.com' && password == 'password123') {
        // Set mock user data
        _token = 'mock_token_for_development';
        _isAuthenticated = true;
        _userId = '1';
        _email = email;
        _userName = 'John Doe';
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        notifyListeners();
        return true;
      }
      
      // Original implementation (commented out for now)
      /*
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final token = data['token'];
        
        // Decode token
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        
        // Save to state
        _token = token;
        _isAuthenticated = true;
        _userId = decodedToken['sub'];
        _email = decodedToken['email'];
        _userName = decodedToken['name'];
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        
        notifyListeners();
        return true;
      } else {
        return false;
      }
      */
      
      return false;
    } catch (e) {
      return false;
    }
  }
  
  // Register method
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      
      // Return whether registration was successful
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
  
  // Logout method
  Future<void> logout() async {
    await _logout();
  }
  
  Future<void> _logout() async {
    _token = null;
    _isAuthenticated = false;
    _userId = null;
    _email = null;
    _userName = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    
    notifyListeners();
  }
} 