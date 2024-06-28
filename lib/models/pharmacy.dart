class Pharmacy {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Pharmacy({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Pharmacy.fromMap(Map<String, dynamic> data, String id) {
    return Pharmacy(
      id: id,
      name: data['name'],
      latitude: data['location'].latitude,
      longitude: data['location'].longitude,
    );
  }
}
