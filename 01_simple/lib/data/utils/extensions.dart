import 'package:drift/drift.dart';
import 'package:flutter_sample_drift/data/datasources/app_database.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';

extension StoreItemDbExtensions on StoreItem {
  StoreItemsTableCompanion toCompanion() {
    return StoreItemsTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      storeId: Value(storeId),
      createdAt: Value(createdAt),
      content: Value(content),
    );
  }
}

extension StoreDbExtensions on Store {
  StoresTableCompanion toCompanion() {
    return StoresTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      createdAt: Value(createdAt),
      name: Value(name),
    );
  }
}
