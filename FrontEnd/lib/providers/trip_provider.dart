import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/trip.dart';
import '../models/destination.dart';
import '../models/activity.dart';

class TripProvider extends ChangeNotifier {
  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<Trip> get trips => [..._trips];
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Get a specific trip by ID
  Trip? getTripById(String id) {
    try {
      return _trips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Get all trips for the current user
  Future<void> fetchTrips() async {
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
        Uri.parse('http://localhost:8080/api/v1/trips'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> tripsData = json.decode(response.body);
        
        final List<Trip> loadedTrips = tripsData.map((tripData) {
          return Trip.fromJson(tripData);
        }).toList();
        
        _trips = loadedTrips;
        notifyListeners();
      } else {
        _setError('Failed to load trips');
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Create a new trip
  Future<bool> createTrip(Trip trip) async {
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
        Uri.parse('http://localhost:8080/api/v1/trips'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(trip.toJson()),
      );
      
      if (response.statusCode == 201) {
        final newTrip = Trip.fromJson(json.decode(response.body));
        _trips.add(newTrip);
        notifyListeners();
        return true;
      } else {
        _setError('Failed to create trip');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Update an existing trip
  Future<bool> updateTrip(Trip trip) async {
    _setLoading(true);
    _error = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token == null) {
        _setError('User not authenticated');
        return false;
      }
      
      final response = await http.put(
        Uri.parse('http://localhost:8080/api/v1/trips/${trip.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(trip.toJson()),
      );
      
      if (response.statusCode == 200) {
        final updatedTrip = Trip.fromJson(json.decode(response.body));
        final index = _trips.indexWhere((t) => t.id == trip.id);
        if (index >= 0) {
          _trips[index] = updatedTrip;
          notifyListeners();
        }
        return true;
      } else {
        _setError('Failed to update trip');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Delete a trip
  Future<bool> deleteTrip(String tripId) async {
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
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 204) {
        _trips.removeWhere((trip) => trip.id == tripId);
        notifyListeners();
        return true;
      } else {
        _setError('Failed to delete trip');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Add a destination to a trip
  Future<bool> addDestination(String tripId, Destination destination) async {
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
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/destinations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(destination.toJson()),
      );
      
      if (response.statusCode == 201) {
        final newDestination = Destination.fromJson(json.decode(response.body));
        final tripIndex = _trips.indexWhere((trip) => trip.id == tripId);
        
        if (tripIndex >= 0) {
          _trips[tripIndex].destinations.add(newDestination);
          notifyListeners();
        }
        return true;
      } else {
        _setError('Failed to add destination');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Add an activity to a destination
  Future<bool> addActivity(String tripId, String destinationId, Activity activity) async {
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
        Uri.parse('http://localhost:8080/api/v1/trips/$tripId/destinations/$destinationId/activities'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(activity.toJson()),
      );
      
      if (response.statusCode == 201) {
        final newActivity = Activity.fromJson(json.decode(response.body));
        final tripIndex = _trips.indexWhere((trip) => trip.id == tripId);
        
        if (tripIndex >= 0) {
          final destIndex = _trips[tripIndex].destinations.indexWhere((dest) => dest.id == destinationId);
          
          if (destIndex >= 0) {
            _trips[tripIndex].destinations[destIndex].activities.add(newActivity);
            notifyListeners();
          }
        }
        return true;
      } else {
        _setError('Failed to add activity');
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
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