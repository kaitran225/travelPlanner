import 'package:flutter/material.dart';
import '../utils/ui_constants.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: const Center(
        child: Text('Trip Detail Screen'),
      ),
    );
  }
} 