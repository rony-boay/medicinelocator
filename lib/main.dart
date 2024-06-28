import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/pharmacist_home_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => LoginScreenRegister(),
          '/user_home': (context) => UserHomeScreen(user: FirebaseAuth.instance.currentUser!),
          '/pharmacist_home': (context) => PharmacistHomeScreen(user: FirebaseAuth.instance.currentUser!),
        },
      ),
    );
  }
}
