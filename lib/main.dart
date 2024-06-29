import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/pharmacist_home_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/inventory_management_screen.dart';
import 'screens/map_screen.dart';
import 'screens/medicine_search_screen.dart';
import 'screens/prescription_submission_screen.dart';
import 'screens/add_pharmacy_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => FirestoreService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Locator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/pharmacist_home': (context) => PharmacistHomeScreen(user: context.read<AuthService>().currentUser!),
        '/user_home': (context) => UserHomeScreen(user: context.read<AuthService>().currentUser!),
      },
    );
  }
}
