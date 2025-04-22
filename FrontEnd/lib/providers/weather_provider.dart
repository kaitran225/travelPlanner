import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';

class WeatherProvider extends ChangeNotifier {
  final Map<String, Weather> _weather = {}; // locationId -> Weather
  final Map<String, DateTime> _lastFetched = {}; // locationId -> DateTime
  bool _isLoading = false;
  String? _error;
  
  // Getters
  Weather? getWeather(String locationId) => _weather[locationId];
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Fetch weather for a location
  Future<Weather?> fetchWeather(String locationId, double lat, double lng) async {
    // Check if we have recently fetched this weather data (within the last hour)
    final now = DateTime.now();
    if (_lastFetched.containsKey(locationId) && 
        now.difference(_lastFetched[locationId]!).inHours < 1 &&
        _weather.containsKey(locationId)) {
      return _weather[locationId];
    }
    
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return null;
      }
      
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/weather?lat=$lat&lng=$lng'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        final Weather weather = Weather.fromJson(weatherData);
        
        _weather[locationId] = weather;
        _lastFetched[locationId] = now;
        
        notifyListeners();
        return weather;
      } else {
        _setError('Failed to load weather data');
        return null;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }
  
  // Get weather forecast for next X days (mocked until API integration)
  Future<List<Weather>> getForecast(String locationId, double lat, double lng, int days) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return [];
      }
      
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/weather/forecast?lat=$lat&lng=$lng&days=$days'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> forecastData = json.decode(response.body);
        final List<Weather> forecast = forecastData.map((data) => Weather.fromJson(data)).toList();
        
        notifyListeners();
        return forecast;
      } else {
        _setError('Failed to load weather forecast');
        return [];
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return [];
    } finally {
      _setLoading(false);
    }
  }
  
  // Get weather alerts for a location
  Future<List<String>> getWeatherAlerts(String locationId, double lat, double lng) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return [];
      }
      
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/weather/alerts?lat=$lat&lng=$lng'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> alertsData = json.decode(response.body);
        final List<String> alerts = alertsData.map((data) => data.toString()).toList();
        
        notifyListeners();
        return alerts;
      } else {
        _setError('Failed to load weather alerts');
        return [];
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return [];
    } finally {
      _setLoading(false);
    }
  }
  
  // Get activity recommendations based on weather
  List<String> getWeatherBasedActivities(String locationId) {
    final weather = _weather[locationId];
    if (weather == null) {
      return [];
    }
    
    final List<String> recommendations = [];
    
    // Based on temperature and conditions
    if (weather.temperature > 25) {
      recommendations.add('Beach visit');
      recommendations.add('Swimming');
      recommendations.add('Water park');
    } else if (weather.temperature > 15) {
      recommendations.add('Hiking');
      recommendations.add('City tour');
      recommendations.add('Outdoor dining');
    } else {
      recommendations.add('Museum visit');
      recommendations.add('Indoor shopping');
      recommendations.add('Coffee shop tour');
    }
    
    // Based on precipitation
    if (weather.precipitation > 0.5) {
      recommendations.add('Indoor activities recommended');
      recommendations.remove('Hiking');
      recommendations.remove('Beach visit');
    }
    
    return recommendations;
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