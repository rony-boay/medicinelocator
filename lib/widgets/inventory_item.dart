import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';

class InventoryItem extends StatelessWidget {
  final Medicine medicine;

  InventoryItem({required this.medicine});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return ListTile(
      title: Text(medicine.name),
      subtitle: Text(
          'Category: ${medicine.category}\nQuantity: ${medicine.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, firestoreService);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              firestoreService.deleteMedicine(medicine.id, medicine.id);
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, FirestoreService firestoreService) {
    final _nameController = TextEditingController(text: medicine.name);
    final _categoryController = TextEditingController(text: medicine.category);
    final _quantityController =
        TextEditingController(text: medicine.quantity.toString());
    final userId = TextEditingController(text: medicine.id);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Medicine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: userId,
                decoration: InputDecoration(labelText: 'userId'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                firestoreService.updateMedicine(
                  medicine.id,
                  _nameController.text,
                  _categoryController.text,
                  int.parse(_quantityController.text) as String,
                  userId as int
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
