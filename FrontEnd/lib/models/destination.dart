import 'activity.dart';

class Destination {
  String id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  double latitude;
  double longitude;
  String address;
  String imageUrl;
  List<Activity> activities;
  
  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.imageUrl = '',
    required this.activities,
  });
  
  // Factory constructor to create Destination from JSON
  factory Destination.fromJson(Map<String, dynamic> json) {
    List<Activity> activities = [];
    
    if (json['activities'] != null) {
      activities = (json['activities'] as List)
          .map((activity) => Activity.fromJson(activity))
          .toList();
    }
    
    return Destination(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      imageUrl: json['imageUrl'] ?? '',
      activities: activities,
    );
  }
  
  // Convert Destination to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'imageUrl': imageUrl,
      'activities': activities.map((activity) => activity.toJson()).toList(),
    };
  }
  
  // Get duration of stay at this destination in days
  int get durationDays {
    return endDate.difference(startDate).inDays + 1;
  }
  
  // Sort activities by start time
  List<Activity> get sortedActivities {
    final sorted = List<Activity>.from(activities);
    sorted.sort((a, b) => a.startTime.compareTo(b.startTime));
    return sorted;
  }
  
  // Group activities by day
  Map<DateTime, List<Activity>> get activitiesByDay {
    final Map<DateTime, List<Activity>> result = {};
    
    for (var activity in activities) {
      // Create a DateTime with just the date part (no time)
      final date = DateTime(
        activity.startTime.year,
        activity.startTime.month,
        activity.startTime.day,
      );
      
      if (!result.containsKey(date)) {
        result[date] = [];
      }
      
      result[date]!.add(activity);
    }
    
    // Sort activities within each day
    result.forEach((date, activities) {
      activities.sort((a, b) => a.startTime.compareTo(b.startTime));
    });
    
    return result;
  }
  
  // Create a copy of the destination with given fields replaced with new values
  Destination copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? latitude,
    double? longitude,
    String? address,
    String? imageUrl,
    List<Activity>? activities,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      activities: activities ?? List.from(this.activities),
    );
  }
} 