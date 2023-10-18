import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';

abstract class StoreRepository {
  Future<void> insertStore(Store store);
  Future<List<Store>> getAllStores();
  Future<void> updateStore(Store store);
  Future<void> deleteStore(Store store);
  Future<void> insertPoint(StoreItem point, Store store);
  Future<List<StoreItem>> getPointsForStore(Store store);
  Future<void> deletePoint(StoreItem point);
}
