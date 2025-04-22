import 'package:flutter/material.dart';
import '../utils/ui_constants.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary'),
      ),
      body: const Center(
        child: Text('Itinerary Screen'),
      ),
    );
  }
} 