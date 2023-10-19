import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';

part 'store_items_state.dart';

class StoreItemsCubit extends Cubit<StoreItemsState> {
  StoreItemsCubit({required StoreRepository repo})
      : _repo = repo,
        super(const StoreItemsStateLoading());

  final StoreRepository _repo;

  Future<void> init(Store store) async {
    emit(const StoreItemsStateLoading());
    final items = await _repo.getItemsForStore(store);
    emit(StoreItemsStateLoaded(items: items));
  }

  Future<void> insertItem(StoreItem item, Store store) async {
    emit(const StoreItemsStateLoading());
    await _repo.insertItem(item, store);
    final items = await _repo.getItemsForStore(store);
    emit(StoreItemsStateLoaded(items: items));
  }

  Future<void> deleteItem(StoreItem item, Store store) async {
    emit(const StoreItemsStateLoading());
    await _repo.deleteItem(item);
    final items = await _repo.getItemsForStore(store);
    emit(StoreItemsStateLoaded(items: items));
  }
}
