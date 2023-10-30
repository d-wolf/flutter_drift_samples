import 'package:drift/drift.dart';
import 'package:drift_self_ref_table/data/datasources/app_database.dart';
import 'package:drift_self_ref_table/domain/entities/store.dart';
import 'package:drift_self_ref_table/domain/entities/store_item.dart';

extension StoreItemDbExtensions on StoreItem {
  StoreItemsTableCompanion toCompanion() {
    return StoreItemsTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      storeId: Value(storeId),
      createdAt: Value(createdAt),
    );
  }
}

extension StoreDbExtensions on Store {
  StoresTableCompanion toCompanion() {
    return StoresTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      storeId: storeId != null ? Value(storeId) : const Value.absent(),
      createdAt: Value(createdAt),
      name: Value(name),
    );
  }
}
