class Place {
  final String id;
  final String name;
  final String description;
  final String image;
  final String address;
  final double latitude;
  final double longitude;
  final String category;
  final double rating;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.rating,
  });
  
  // Factory constructor to create Place from JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: json['category'],
      rating: json['rating'],
    );
  }
  
  // Convert Place to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'rating': rating,
    };
  }
} 