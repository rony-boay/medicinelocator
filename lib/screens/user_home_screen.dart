import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'map_screen.dart';
import 'medicine_search_screen.dart';
import 'prescription_submission_screen.dart';
import '../services/auth_service.dart';

class UserHomeScreen extends StatelessWidget {
  final User user;

  UserHomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Medicine Locator'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Search Medicine'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicineSearchScreen()),
                );
              },
            ),
            ListTile(
              title: Text('View Nearby Pharmacies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Submit Prescription'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrescriptionSubmissionScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome, ${user.email}!'),
      ),
    );
  }
}
