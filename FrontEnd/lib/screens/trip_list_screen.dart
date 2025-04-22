import 'package:flutter/material.dart';
import '../utils/ui_constants.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: const Center(
        child: Text('Trip List Screen'),
      ),
    );
  }
} 