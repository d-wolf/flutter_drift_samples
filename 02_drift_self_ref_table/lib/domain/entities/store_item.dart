class StoreItem {
  StoreItem({
    required this.storeId,
    required this.createdAt,
    this.id,
  });
  final int? id;
  final int storeId;
  final DateTime createdAt;
}
