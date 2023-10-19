class StoreItem {
  StoreItem({
    required this.storeId,
    required this.createdAt,
    this.content = '',
    this.id,
  });
  final int? id;
  final int storeId;
  final DateTime createdAt;

  /// new, added column in v2
  final String content;
}
