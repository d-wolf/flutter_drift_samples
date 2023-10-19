part of 'store_items_cubit.dart';

sealed class StoreItemsState extends Equatable {
  const StoreItemsState();

  @override
  List<Object?> get props => [];
}

final class StoreItemsStateLoading extends StoreItemsState {
  const StoreItemsStateLoading();
}

final class StoreItemsStateLoaded extends StoreItemsState {
  const StoreItemsStateLoaded({required this.items});
  final List<StoreItem> items;

  @override
  List<Object?> get props => [items];
}
