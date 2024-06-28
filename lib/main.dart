import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/inventory_management_screen.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/pharmacist_home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/add_pharmacy_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Medicine Locator',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/user_home': (context) => UserHomeScreen(user: Provider.of<AuthService>(context).currentUser!),
          '/pharmacist_home': (context) => PharmacistHomeScreen(user: Provider.of<AuthService>(context).currentUser!),
          '/map': (context) => MapScreen(),
          '/inventory': (context) => InventoryManagementScreen(user: Provider.of<AuthService>(context).currentUser!),
          '/add_pharmacy': (context) => AddPharmacyScreen(user: Provider.of<AuthService>(context).currentUser!),
        },
      ),
    );
  }
}
