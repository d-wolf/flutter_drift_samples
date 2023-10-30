class Store {
  Store({
    required this.createdAt,
    required this.name,
    this.id,
  });
  final int? id;
  final DateTime createdAt;
  final String name;
}
