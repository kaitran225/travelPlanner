import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/trip_provider.dart';
import '../utils/ui_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const _HomeTab(),
    const _TripsTab(),
    const _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // Navigate to create trip screen
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Travel Planner'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // Navigate to notifications
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome section
                  Text(
                    'Welcome back!',
                    style: AppTextStyles.headingL,
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text(
                    'Ready for your next adventure?',
                    style: AppTextStyles.bodyL.copyWith(
                      color: AppColors.mediumGrey,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  // Upcoming trips section
                  Text(
                    'Upcoming Trips',
                    style: AppTextStyles.headingM,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  // Placeholder for upcoming trips
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            size: AppDimensions.iconXL,
                            color: AppColors.mediumGrey,
                          ),
                          const SizedBox(height: AppDimensions.paddingM),
                          Text(
                            'No upcoming trips',
                            style: AppTextStyles.bodyL.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.paddingS),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to create trip
                            },
                            style: AppDecorations.primaryButtonStyle.copyWith(
                              minimumSize: const Size(200, AppDimensions.buttonHeightM),
                            ),
                            child: const Text('Plan a Trip'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  // Quick actions section
                  Text(
                    'Quick Actions',
                    style: AppTextStyles.headingM,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  // Quick action buttons
                  Row(
                    children: [
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.add_location_alt,
                          label: 'Add Place',
                          onTap: () {
                            // Navigate to add place
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.calendar_today,
                          label: 'Itinerary',
                          onTap: () {
                            // Navigate to itinerary
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.account_balance_wallet,
                          label: 'Budget',
                          onTap: () {
                            // Navigate to budget
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: AppColors.lightGrey,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconL,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              label,
              style: AppTextStyles.bodyM.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TripsTab extends StatelessWidget {
  const _TripsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('My Trips'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Navigate to search
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Show filter options
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder for trips list
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: AppDimensions.iconXXL,
                            color: AppColors.mediumGrey,
                          ),
                          const SizedBox(height: AppDimensions.paddingM),
                          Text(
                            'No trips yet',
                            style: AppTextStyles.headingM.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.paddingS),
                          Text(
                            'Start planning your first trip',
                            style: AppTextStyles.bodyL.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.paddingL),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to create trip
                            },
                            style: AppDecorations.primaryButtonStyle.copyWith(
                              minimumSize: const Size(200, AppDimensions.buttonHeightM),
                            ),
                            child: const Text('Create Trip'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  // Navigate to settings
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                children: [
                  // Profile header
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile picture
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: AppDimensions.iconXXL,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingL),
                        
                        // User name
                        Text(
                          'John Doe',
                          style: AppTextStyles.headingM,
                        ),
                        const SizedBox(height: AppDimensions.paddingS),
                        
                        // User email
                        Text(
                          'john.doe@example.com',
                          style: AppTextStyles.bodyM.copyWith(
                            color: AppColors.mediumGrey,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingL),
                        
                        // Edit profile button
                        OutlinedButton(
                          onPressed: () {
                            // Navigate to edit profile
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                            ),
                          ),
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  // Stats section
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.flight_takeoff,
                          value: '0',
                          label: 'Trips',
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.place,
                          value: '0',
                          label: 'Places',
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.photo,
                          value: '0',
                          label: 'Photos',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  // Menu items
                  _MenuItem(
                    icon: Icons.history,
                    label: 'Trip History',
                    onTap: () {
                      // Navigate to trip history
                    },
                  ),
                  _MenuItem(
                    icon: Icons.favorite_border,
                    label: 'Saved Places',
                    onTap: () {
                      // Navigate to saved places
                    },
                  ),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {
                      // Navigate to notifications
                    },
                  ),
                  _MenuItem(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                  _MenuItem(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
                      // Show logout confirmation
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Logout
                                Provider.of<AuthProvider>(context, listen: false).logout();
                                Navigator.of(context).pushReplacementNamed('/login');
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: AppDimensions.iconL,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            value,
            style: AppTextStyles.headingM,
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          Text(
            label,
            style: AppTextStyles.bodyS.copyWith(
              color: AppColors.mediumGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingS,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconM,
              color: AppColors.mediumGrey,
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Text(
              label,
              style: AppTextStyles.bodyL,
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              size: AppDimensions.iconM,
              color: AppColors.mediumGrey,
            ),
          ],
        ),
      ),
    );
  }
} 