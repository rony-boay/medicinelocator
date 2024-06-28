import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryManagementScreen extends StatelessWidget {
  final User user;

  InventoryManagementScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pharmacies')
            .doc(user.uid)
            .collection('inventory')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              int quantity = data['quantity'];
              return ListTile(
                title: Text(data['name']),
                subtitle: Text('Quantity: $quantity'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Edit inventory item
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
