class InventoryItem {
  final String id;
  final String name;
  final int quantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory InventoryItem.fromMap(Map<String, dynamic> data, String id) {
    return InventoryItem(
      id: id,
      name: data['name'],
      quantity: data['quantity'],
    );
  }
}
