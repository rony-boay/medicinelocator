import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../widgets/inventory_item.dart';

class InventoryManagementScreen extends StatelessWidget {
  final User user;

  InventoryManagementScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: StreamBuilder(
        stream: firestoreService.getMedicines(user.uid),
        builder: (context, AsyncSnapshot<List<Medicine>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No medicines in inventory.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final medicine = snapshot.data![index];
              return InventoryItem(medicine: medicine);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add medicine functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
