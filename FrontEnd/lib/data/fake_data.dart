import 'package:travelplanner/models/destination.dart';

import '../models/trip.dart';
import '../models/user.dart';
import '../models/place.dart';
import '../models/itinerary.dart';
import '../models/budget.dart';

class FakeData {
  // Sample user data
  static final User currentUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    profilePicture: 'https://randomuser.me/api/portraits/men/32.jpg',
    tripsCount: 5,
    placesCount: 12,
    photosCount: 24,
  );

  // Sample trips data
  static final List<Trip> trips = [
    Trip(
      id: '1',
      title: 'Paris Adventure',
      description: 'A week exploring the City of Light',
      startDate: DateTime.now().add(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 22)),
      coverImage: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      places: [
        Place(
          id: '1',
          name: 'Eiffel Tower',
          description: 'Iconic iron lattice tower on the Champ de Mars in Paris',
          image: 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f',
          address: 'Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France',
          latitude: 48.8584,
          longitude: 2.2945,
          category: 'Attraction',
          rating: 4.7,
        ),
        Place(
          id: '2',
          name: 'Louvre Museum',
          description: 'World\'s largest art museum and a historic monument',
          image: 'https://images.unsplash.com/photo-1547981609-4b6bfe67ca0b',
          address: 'Rue de Rivoli, 75001 Paris, France',
          latitude: 48.8606,
          longitude: 2.3376,
          category: 'Museum',
          rating: 4.8,
        ),
      ],
      itinerary: Itinerary(
        id: '1',
        days: [
          ItineraryDay(
            id: '1',
            date: DateTime.now().add(const Duration(days: 15)),
            activities: [
              Activity(
                id: '1',
                title: 'Arrival in Paris',
                description: 'Check-in at hotel and evening walk along the Seine',
                startTime: '14:00',
                endTime: '20:00',
                placeId: null,
              ),
            ],
          ),
          ItineraryDay(
            id: '2',
            date: DateTime.now().add(const Duration(days: 16)),
            activities: [
              Activity(
                id: '2',
                title: 'Visit Eiffel Tower',
                description: 'Morning visit to the iconic landmark',
                startTime: '09:00',
                endTime: '12:00',
                placeId: '1',
              ),
              Activity(
                id: '3',
                title: 'Lunch at Le Bistrot',
                description: 'Traditional French cuisine',
                startTime: '12:30',
                endTime: '14:00',
                placeId: null,
              ),
              Activity(
                id: '4',
                title: 'Louvre Museum',
                description: 'Afternoon exploring the world\'s largest art museum',
                startTime: '15:00',
                endTime: '18:00',
                placeId: '2',
              ),
            ],
          ),
        ],
      ),
      budget: Budget(
        id: '1',
        total: 2500.0,
        spent: 0.0,
        categories: [
          BudgetCategory(
            id: '1',
            name: 'Accommodation',
            budgeted: 1200.0,
            spent: 0.0,
          ),
          BudgetCategory(
            id: '2',
            name: 'Transportation',
            budgeted: 500.0,
            spent: 0.0,
          ),
          BudgetCategory(
            id: '3',
            name: 'Food',
            budgeted: 400.0,
            spent: 0.0,
          ),
          BudgetCategory(
            id: '4',
            name: 'Activities',
            budgeted: 400.0,
            spent: 0.0,
          ),
        ],
      ),
      destinations: [
        Destination(
          id: '1',
          name: 'Paris',
          country: 'France',
          image: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        ),
      ],
      companions: ['Jane Doe', 'Mike Smith'],
    ),
    Trip(
      id: '2',
      title: 'Tokyo Explorer',
      description: 'Two weeks in Japan\'s vibrant capital',
      startDate: DateTime.now().add(const Duration(days: 45)),
      endDate: DateTime.now().add(const Duration(days: 59)),
      coverImage: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
      places: [],
      itinerary: Itinerary(id: '2', days: []),
      budget: Budget(
        id: '2',
        total: 3500.0,
        spent: 0.0,
        categories: [],
      ),
      destinations: [
        Destination(
          id: '2',
          name: 'Tokyo',
          country: 'Japan',
          image: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
        ),
      ],
      companions: ['Sarah Johnson'],
    ),
    Trip(
      id: '3',
      title: 'New York City Weekend',
      description: 'Quick getaway to the Big Apple',
      startDate: DateTime.now().add(const Duration(days: 90)),
      endDate: DateTime.now().add(const Duration(days: 93)),
      coverImage: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
      places: [],
      itinerary: Itinerary(id: '3', days: []),
      budget: Budget(
        id: '3',
        total: 1500.0,
        spent: 0.0,
        categories: [],
      ),
      destinations: [
        Destination(
          id: '3',
          name: 'New York City',
          country: 'USA',
          image: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
        ),
      ],
      companions: ['Alex Brown'],
    ),
  ];

  // Sample saved places
  static final List<Place> savedPlaces = [
    Place(
      id: '3',
      name: 'Santorini',
      description: 'Stunning Greek island known for its white-washed buildings and blue domes',
      image: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff',
      address: 'Santorini, Greece',
      latitude: 36.3932,
      longitude: 25.4615,
      category: 'Destination',
      rating: 4.9,
    ),
    Place(
      id: '4',
      name: 'Bali',
      description: 'Indonesian island known for its forested volcanic mountains, iconic rice paddies, beaches and coral reefs',
      image: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
      address: 'Bali, Indonesia',
      latitude: -8.3405,
      longitude: 115.0920,
      category: 'Destination',
      rating: 4.8,
    ),
  ];

  // Sample notifications
  static final List<Notification> notifications = [
    Notification(
      id: '1',
      title: 'Trip Reminder',
      message: 'Your Paris trip starts in 15 days!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    Notification(
      id: '2',
      title: 'Flight Alert',
      message: 'Your flight to Paris has been confirmed',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];
}

// Simple notification model
class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });
} 