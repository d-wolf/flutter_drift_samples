import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';

abstract class StoreRepository {
  Future<void> insertStore(Store store);
  Future<List<Store>> getAllStores();
  Future<void> updateStore(Store store);
  Future<void> deleteStore(Store store);
  Future<void> insertItem(StoreItem item, Store store);
  Future<List<StoreItem>> getItemsForStore(Store store);
  Future<void> deleteItem(StoreItem point);
}
