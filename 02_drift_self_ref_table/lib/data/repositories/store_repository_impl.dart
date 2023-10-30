import 'package:drift/drift.dart';
import 'package:drift_self_ref_table/data/datasources/app_database.dart';
import 'package:drift_self_ref_table/data/utils/extensions.dart';
import 'package:drift_self_ref_table/domain/entities/store.dart';
import 'package:drift_self_ref_table/domain/entities/store_item.dart';
import 'package:drift_self_ref_table/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<void> insertStore(Store store) async {
    await _database.into(_database.storesTable).insert(store.toCompanion());
  }

  @override
  Future<void> insertChildStore(Store parent, Store child) async {
    await _database.into(_database.storesTable).insert(
          Store(
            createdAt: child.createdAt,
            name: child.name,
            storeId: parent.id,
          ).toCompanion(),
        );
  }

  @override
  Future<List<Store>> getStores([Store? parent]) async {
    final query = parent != null
        ? (_database.select(_database.storesTable)
          ..where((tbl) => tbl.storeId.equals(parent.id!)))
        : _database.select(_database.storesTable);
    return query.get();
  }

  @override
  Future<int?> countStores([Store? parent]) async {
    final count = countAll(
      filter: parent != null
          ? _database.storesTable.storeId.equals(parent.id!)
          : null,
    );

    final result = await (_database.selectOnly(_database.storesTable)
          ..addColumns([count]))
        .map((row) => row.read(count))
        .getSingle();

    return result;
  }

  @override
  Future<bool> hasStores([Store? parent]) async {
    final result = await countStores(parent);
    if (result != null) {
      return result > 0;
    }
    return false;
  }

  @override
  Future<void> updateStore(Store store) async {
    await _database.update(_database.storesTable).replace(store.toCompanion());
  }

  @override
  Future<void> deleteStore(Store store) async {
    await _database.delete(_database.storesTable).delete(store.toCompanion());
  }

  @override
  Future<void> insertStoreItem(StoreItem point, Store store) async {
    await _database.into(_database.storeItemsTable).insert(point.toCompanion());
  }

  @override
  Future<List<StoreItem>> getStoreItems([Store? parent]) async {
    if (parent == null) return [];

    final query = (_database.select(_database.storeItemsTable)
      ..where((tbl) => tbl.storeId.equals(parent.id!)));
    return query.get();
  }

  @override
  Future<void> deleteStoreItem(StoreItem point) async {
    await _database
        .delete(_database.storeItemsTable)
        .delete(point.toCompanion());
  }
}
