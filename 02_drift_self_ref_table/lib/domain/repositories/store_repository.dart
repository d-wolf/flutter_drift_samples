import 'package:drift_self_ref_table/domain/entities/store.dart';
import 'package:drift_self_ref_table/domain/entities/store_item.dart';

abstract class StoreRepository {
  Future<void> insertStore(Store store);
  Future<void> insertChildStore(Store parent, Store child);
  Future<int?> countStores([Store? parent]);
  Future<bool> hasStores([Store? parent]);
  Future<List<Store>> getStores([Store? parent]);
  Future<void> updateStore(Store store);
  Future<void> deleteStore(Store store);
  Future<void> insertStoreItem(StoreItem point, Store store);
  Future<List<StoreItem>> getStoreItems([Store? parent]);
  Future<void> deleteStoreItem(StoreItem point);
}
