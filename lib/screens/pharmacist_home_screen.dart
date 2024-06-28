import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'add_pharmacy_screen.dart';
import 'inventory_management_screen.dart';
import '../services/auth_service.dart';

class PharmacistHomeScreen extends StatelessWidget {
  final User user;

  PharmacistHomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacist Home'),
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
              title: Text('Add Pharmacy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPharmacyScreen(user: user)),
                );
              },
            ),
            ListTile(
              title: Text('Inventory Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventoryManagementScreen(user: user)),
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
