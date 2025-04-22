class Activity {
  String id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  String location;
  double? latitude;
  double? longitude;
  String category;
  double cost;
  bool isBooked;
  String bookingReference;
  
  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.latitude,
    this.longitude,
    required this.category,
    this.cost = 0.0,
    this.isBooked = false,
    this.bookingReference = '',
  });
  
  // Factory constructor to create Activity from JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: json['category'],
      cost: json['cost'] ?? 0.0,
      isBooked: json['isBooked'] ?? false,
      bookingReference: json['bookingReference'] ?? '',
    );
  }
  
  // Convert Activity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'cost': cost,
      'isBooked': isBooked,
      'bookingReference': bookingReference,
    };
  }
  
  // Get duration of the activity in minutes
  int get durationMinutes {
    return endTime.difference(startTime).inMinutes;
  }
  
  // Check if the activity overlaps with another activity
  bool overlaps(Activity other) {
    return (startTime.isBefore(other.endTime) && 
            endTime.isAfter(other.startTime));
  }
  
  // Create a copy of the activity with given fields replaced with new values
  Activity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    double? latitude,
    double? longitude,
    String? category,
    double? cost,
    bool? isBooked,
    String? bookingReference,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      isBooked: isBooked ?? this.isBooked,
      bookingReference: bookingReference ?? this.bookingReference,
    );
  }
}
 