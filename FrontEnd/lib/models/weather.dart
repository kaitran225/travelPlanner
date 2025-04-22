class Weather {
  double temperature;
  double feelsLike;
  double tempMin;
  double tempMax;
  int humidity;
  int pressure;
  double windSpeed;
  int windDegree;
  String description;
  String iconCode;
  double precipitation;
  double uvi;
  DateTime timestamp;
  
  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDegree,
    required this.description,
    required this.iconCode,
    this.precipitation = 0.0,
    required this.uvi,
    required this.timestamp,
  });
  
  // Factory constructor to create Weather from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      feelsLike: json['feelsLike'],
      tempMin: json['tempMin'],
      tempMax: json['tempMax'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      windSpeed: json['windSpeed'],
      windDegree: json['windDegree'],
      description: json['description'],
      iconCode: json['iconCode'],
      precipitation: json['precipitation'] ?? 0.0,
      uvi: json['uvi'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
  
  // Convert Weather to JSON
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'humidity': humidity,
      'pressure': pressure,
      'windSpeed': windSpeed,
      'windDegree': windDegree,
      'description': description,
      'iconCode': iconCode,
      'precipitation': precipitation,
      'uvi': uvi,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  // Helper to get icon URL
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
  
  // Check if weather is favorable for outdoor activities
  bool get isFavorableForOutdoor {
    return temperature > 15 && // Not too cold
           precipitation < 0.5 && // Not heavy rain
           windSpeed < 10; // Not too windy
  }
  
  // Get weather condition category
  String get condition {
    if (description.contains('rain') || 
        description.contains('drizzle') || 
        description.contains('shower')) {
      return 'rainy';
    } else if (description.contains('snow') || 
               description.contains('sleet') || 
               description.contains('ice')) {
      return 'snowy';
    } else if (description.contains('cloud')) {
      return 'cloudy';
    } else if (description.contains('clear')) {
      return 'clear';
    } else if (description.contains('storm') || 
               description.contains('thunder')) {
      return 'stormy';
    } else {
      return 'other';
    }
  }
} 