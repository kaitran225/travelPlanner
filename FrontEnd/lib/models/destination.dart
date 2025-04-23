import 'activity.dart';

class Destination {
  final String id;
  final String name;
  final String country;
  final String image;
  final List<Activity> activities;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.image,
    this.activities = const [],
  });
  
  // Factory constructor to create Destination from JSON
  factory Destination.fromJson(Map<String, dynamic> json) {
    List<Activity> activityList = [];
    
    if (json['activities'] != null) {
      activityList = (json['activities'] as List)
          .map((activity) => Activity.fromJson(activity))
          .toList();
    }
    
    return Destination(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      image: json['image'],
      activities: activityList,
    );
  }
  
  // Convert Destination to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'image': image,
      'activities': activities.map((activity) => activity.toJson()).toList(),
    };
  }
  
  // Create a copy of the destination with given fields replaced with new values
  Destination copyWith({
    String? id,
    String? name,
    String? country,
    String? image,
    List<Activity>? activities,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      image: image ?? this.image,
      activities: activities ?? List.from(this.activities),
    );
  }
} 