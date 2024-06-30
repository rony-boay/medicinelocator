import 'package:flutter/material.dart';
import 'package:medicinelocator1/screens/user_type_selection.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/pharmacist_home_screen.dart';
import 'screens/user_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/user_type_selection': (context) => UserTypeSelectionScreen(),
        '/pharmacist_home': (context) =>
            PharmacistHomeScreen(user: context.read<AuthService>().currentUser!),
        '/user_home': (context) =>
            UserHomeScreen(user: context.read<AuthService>().currentUser!),
      },
    );
  }
}
