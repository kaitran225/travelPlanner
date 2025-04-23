import 'place.dart';
import 'itinerary.dart';
import 'budget.dart';
import 'destination.dart';

class Trip {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String coverImage;
  final List<Place> places;
  final Itinerary itinerary;
  final Budget budget;
  final List<Destination> destinations;
  final List<String> companions;
  final bool isPublic;
  
  Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.coverImage,
    required this.places,
    required this.itinerary,
    required this.budget,
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
      coverImage: json['coverImage'],
      places: (json['places'] as List)
          .map((place) => Place.fromJson(place))
          .toList(),
      itinerary: Itinerary.fromJson(json['itinerary']),
      budget: Budget.fromJson(json['budget']),
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
      'coverImage': coverImage,
      'places': places.map((place) => place.toJson()).toList(),
      'itinerary': itinerary.toJson(),
      'budget': budget.toJson(),
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
    String? coverImage,
    List<Place>? places,
    Itinerary? itinerary,
    Budget? budget,
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
      coverImage: coverImage ?? this.coverImage,
      places: places ?? List.from(this.places),
      itinerary: itinerary ?? this.itinerary,
      budget: budget ?? this.budget,
      destinations: destinations ?? List.from(this.destinations),
      companions: companions ?? List.from(this.companions),
      isPublic: isPublic ?? this.isPublic,
    );
  }
} 