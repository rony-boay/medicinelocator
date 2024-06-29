import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import '../services/firestore_service.dart';
import 'map_screen.dart';

class MedicineSearchScreen extends StatefulWidget {
  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  final _searchController = TextEditingController();
  List<DocumentSnapshot>? _searchResults;

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Enter medicine name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                QuerySnapshot result = await firestoreService.searchMedicine(_searchController.text);
                setState(() {
                  _searchResults = result.docs;
                });
              },
              child: Text('Search'),
            ),
            _searchResults != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults!.length,
                      itemBuilder: (context, index) {
                        var doc = _searchResults![index];
                        return ListTile(
                          title: Text(doc['name']),
                          subtitle: Text('Available in nearby pharmacies'),
                          onTap: () async {
                            LatLng userLocation = LatLng(0, 0); // Replace with actual user location
                            List<DocumentSnapshot> pharmacies = await firestoreService.getNearbyPharmaciesWithMedicine(
                              doc['name'], userLocation);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  pharmacies: pharmacies,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
