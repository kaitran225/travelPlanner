import 'destination.dart';

class Trip {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  List<Destination> destinations;
  List<String> companions;
  bool isPublic;
  
  Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.destinations,
    required this.companions,
    this.isPublic = false,
  });
  
  // Factory constructor to create Trip from JSON
  factory Trip.fromJson(Map<String, dynamic> json) {
    List<Destination> destinations = [];
    
    if (json['destinations'] != null) {
      destinations = (json['destinations'] as List)
          .map((destination) => Destination.fromJson(destination))
          .toList();
    }
    
    List<String> companions = [];
    if (json['companions'] != null) {
      companions = (json['companions'] as List)
          .map((companion) => companion.toString())
          .toList();
    }
    
    return Trip(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      destinations: destinations,
      companions: companions,
      isPublic: json['isPublic'] ?? false,
    );
  }
  
  // Convert Trip to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'destinations': destinations.map((destination) => destination.toJson()).toList(),
      'companions': companions,
      'isPublic': isPublic,
    };
  }
  
  // Get total duration of trip in days
  int get durationDays {
    return endDate.difference(startDate).inDays + 1;
  }
  
  // Check if trip is upcoming
  bool get isUpcoming {
    return startDate.isAfter(DateTime.now());
  }
  
  // Check if trip is ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return startDate.isBefore(now) && endDate.isAfter(now);
  }
  
  // Check if trip is completed
  bool get isCompleted {
    return endDate.isBefore(DateTime.now());
  }
  
  // Create a copy of the trip with given fields replaced with new values
  Trip copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<Destination>? destinations,
    List<String>? companions,
    bool? isPublic,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      destinations: destinations ?? List.from(this.destinations),
      companions: companions ?? List.from(this.companions),
      isPublic: isPublic ?? this.isPublic,
    );
  }
} 