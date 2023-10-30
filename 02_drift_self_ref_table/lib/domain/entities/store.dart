class Store {
  Store({
    required this.createdAt,
    required this.name,
    this.storeId,
    this.id,
  });
  final int? id;
  final int? storeId;
  final DateTime createdAt;
  final String name;

  bool get isRoot => storeId == null;
}
