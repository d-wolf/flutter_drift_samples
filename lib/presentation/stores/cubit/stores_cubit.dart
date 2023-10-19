import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit({required StoreRepository repo})
      : _repo = repo,
        super(const StoresStateLoading());

  final StoreRepository _repo;

  Future<void> init() async {
    emit(const StoresStateLoading());
    final stores = await _repo.getAllStores();
    emit(StoresStateLoaded(stores: stores));
  }

  Future<void> insertStore(Store store) async {
    emit(const StoresStateLoading());
    await _repo.insertStore(store);
    final stores = await _repo.getAllStores();
    emit(StoresStateLoaded(stores: stores));
  }

  Future<void> updateStore(Store store) async {
    emit(const StoresStateLoading());
    await _repo.updateStore(store);
    final stores = await _repo.getAllStores();
    emit(StoresStateLoaded(stores: stores));
  }

  Future<void> deleteStore(Store store) async {
    emit(const StoresStateLoading());
    await _repo.deleteStore(store);
    final all = await _repo.getItemsForStore(store);
    // any items left?
    debugPrint('items left: $all');
    final stores = await _repo.getAllStores();
    emit(StoresStateLoaded(stores: stores));
  }
}
