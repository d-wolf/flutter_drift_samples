part of 'stores_cubit.dart';

sealed class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object?> get props => [];
}

class StoresStateLoading extends StoresState {
  const StoresStateLoading();
}

class StoresStateLoaded extends StoresState {
  const StoresStateLoaded({
    required this.stores,
    required this.items,
  });

  final List<Store> stores;
  final List<StoreItem> items;

  @override
  List<Object?> get props => [stores, items];
}
