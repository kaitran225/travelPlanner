class Itinerary {
  final String id;
  final List<ItineraryDay> days;

  Itinerary({
    required this.id,
    required this.days,
  });
  
  // Factory constructor to create Itinerary from JSON
  factory Itinerary.fromJson(Map<String, dynamic> json) {
    List<ItineraryDay> dayList = [];
    
    if (json['days'] != null) {
      dayList = (json['days'] as List)
          .map((day) => ItineraryDay.fromJson(day))
          .toList();
    }
    
    return Itinerary(
      id: json['id'],
      days: dayList,
    );
  }
  
  // Convert Itinerary to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'days': days.map((day) => day.toJson()).toList(),
    };
  }
}

class ItineraryDay {
  final String id;
  final DateTime date;
  final List<Activity> activities;

  ItineraryDay({
    required this.id,
    required this.date,
    required this.activities,
  });
  
  // Factory constructor to create ItineraryDay from JSON
  factory ItineraryDay.fromJson(Map<String, dynamic> json) {
    List<Activity> activityList = [];
    
    if (json['activities'] != null) {
      activityList = (json['activities'] as List)
          .map((activity) => Activity.fromJson(activity))
          .toList();
    }
    
    return ItineraryDay(
      id: json['id'],
      date: DateTime.parse(json['date']),
      activities: activityList,
    );
  }
  
  // Convert ItineraryDay to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'activities': activities.map((activity) => activity.toJson()).toList(),
    };
  }
}

class Activity {
  final String id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String? placeId;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.placeId,
  });
  
  // Factory constructor to create Activity from JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      placeId: json['placeId'],
    );
  }
  
  // Convert Activity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'placeId': placeId,
    };
  }
} 