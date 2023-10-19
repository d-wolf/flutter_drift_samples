import 'package:flutter_sample_drift/data/datasources/app_database.dart';
import 'package:flutter_sample_drift/data/utils/extensions.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<void> insertStore(Store store) async {
    await _database.into(_database.storesTable).insert(store.toCompanion());
  }

  @override
  Future<List<Store>> getAllStores() async {
    return _database.select(_database.storesTable).get();
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
  Future<void> insertItem(StoreItem point, Store store) async {
    await _database.into(_database.storeItemsTable).insert(point.toCompanion());
  }

  @override
  Future<List<StoreItem>> getItemsForStore(Store store) async {
    return (_database.select(_database.storeItemsTable)
          ..where((tbl) => tbl.storeId.equals(store.id!)))
        .get();
  }

  @override
  Future<void> deleteItem(StoreItem point) async {
    await _database
        .delete(_database.storeItemsTable)
        .delete(point.toCompanion());
  }
}
