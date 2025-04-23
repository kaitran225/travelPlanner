class User {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final int tripsCount;
  final int placesCount;
  final int photosCount;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.tripsCount = 0,
    this.placesCount = 0,
    this.photosCount = 0,
  });
} 