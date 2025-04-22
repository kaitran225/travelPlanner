import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Import screens (we'll create these later)
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/trip_list_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/itinerary_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/profile_screen.dart';

// Import providers (we'll create these later)
import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';
import 'providers/budget_provider.dart';
import 'providers/weather_provider.dart';

// Import UI constants
import 'utils/ui_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // Check if user is logged in
  final String? token = prefs.getString('auth_token');
  
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Travel Planner',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        themeMode: ThemeMode.system,
        home: token != null ? const HomeScreen() : const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/trips': (context) => const TripListScreen(),
          '/trip_detail': (context) => const TripDetailScreen(),
          '/itinerary': (context) => const ItineraryScreen(),
          '/budget': (context) => const BudgetScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
  
  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: brightness == Brightness.light
          ? ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              primaryContainer: AppColors.primaryLight.withOpacity(0.2),
              onPrimaryContainer: AppColors.primaryDark,
              secondary: AppColors.accent,
              onSecondary: AppColors.white,
              secondaryContainer: AppColors.accentLight.withOpacity(0.2),
              onSecondaryContainer: AppColors.accentDark,
              error: AppColors.error,
              surface: AppColors.white,
              background: AppColors.offWhite,
              onBackground: AppColors.black,
            )
          : ColorScheme.dark(
              primary: AppColors.primaryLight,
              onPrimary: AppColors.white,
              primaryContainer: AppColors.primary.withOpacity(0.2),
              onPrimaryContainer: AppColors.primaryLight,
              secondary: AppColors.accent,
              onSecondary: AppColors.white,
              secondaryContainer: AppColors.accent.withOpacity(0.2),
              onSecondaryContainer: AppColors.accentLight,
              error: AppColors.error,
              surface: AppColors.darkGrey,
              background: AppColors.black,
              onBackground: AppColors.white,
            ),
      textTheme: GoogleFonts.poppinsTextTheme(
        brightness == Brightness.light
            ? ThemeData.light().textTheme
            : ThemeData.dark().textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? AppColors.offWhite
            : AppColors.darkGrey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: brightness == Brightness.light
                ? AppColors.primary
                : AppColors.primaryLight,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brightness == Brightness.light
              ? AppColors.primary
              : AppColors.primaryLight,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          textStyle: AppTextStyles.buttonM,
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeightM),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brightness == Brightness.light
              ? AppColors.primary
              : AppColors.primaryLight,
          side: BorderSide(
            color: brightness == Brightness.light
                ? AppColors.primary
                : AppColors.primaryLight,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          textStyle: AppTextStyles.buttonM,
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeightM),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: brightness == Brightness.light
              ? AppColors.primary
              : AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          textStyle: AppTextStyles.buttonM,
        ),
      ),
      cardTheme: CardTheme(
        color: brightness == Brightness.light
            ? AppColors.white
            : AppColors.darkGrey,
        surfaceTintColor: Colors.transparent,
        elevation: AppDimensions.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light
            ? AppColors.white
            : AppColors.black,
        foregroundColor: brightness == Brightness.light
            ? AppColors.black
            : AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.headingS.copyWith(
          color: brightness == Brightness.light
              ? AppColors.black
              : AppColors.white,
        ),
        iconTheme: IconThemeData(
          color: brightness == Brightness.light
              ? AppColors.black
              : AppColors.white,
          size: AppDimensions.iconM,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: brightness == Brightness.light
            ? AppColors.white
            : AppColors.black,
        selectedItemColor: brightness == Brightness.light
            ? AppColors.primary
            : AppColors.primaryLight,
        unselectedItemColor: AppColors.mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationM,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      dividerTheme: DividerThemeData(
        color: brightness == Brightness.light
            ? AppColors.lightGrey
            : AppColors.darkGrey,
        thickness: 1,
        space: 1,
      ),
    );
    
    return baseTheme;
  }
}
