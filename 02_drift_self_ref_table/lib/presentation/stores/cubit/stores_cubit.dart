import 'package:drift_self_ref_table/domain/entities/store.dart';
import 'package:drift_self_ref_table/domain/entities/store_item.dart';
import 'package:drift_self_ref_table/domain/repositories/store_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit({required StoreRepository repo})
      : _repo = repo,
        super(const StoresStateLoading());

  final StoreRepository _repo;

  Future<void> init(Store? root) async {
    emit(const StoresStateLoading());
    final stores = await _repo.getStores(root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: stores, items: items));
  }

  Future<void> insertStore(Store? root, Store store) async {
    emit(const StoresStateLoading());
    await _repo.insertStore(store);
    final stores = await _repo.getStores(root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: stores, items: items));
  }

  Future<void> updateStore(Store? root, Store store) async {
    emit(const StoresStateLoading());
    await _repo.updateStore(store);
    final stores = await _repo.getStores(root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: stores, items: items));
  }

  Future<void> deleteStore(Store? root, Store store) async {
    emit(const StoresStateLoading());
    await _repo.deleteStore(store);
    final stores = await _repo.getStores(root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: stores, items: items));
  }

  Future<void> insertItem(Store root, StoreItem item) async {
    emit(const StoresStateLoading());
    await _repo.insertStoreItem(item, root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: const [], items: items));
  }

  Future<void> deleteItem(Store root, StoreItem item) async {
    emit(const StoresStateLoading());
    await _repo.deleteStoreItem(item);
    final stores = await _repo.getStores(root);
    final items = await _repo.getStoreItems(root);
    emit(StoresStateLoaded(stores: stores, items: items));
  }
}
