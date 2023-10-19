import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';
import 'package:flutter_sample_drift/presentation/store_items/cubit/store_items_cubit.dart';

class StoreItemsPage extends StatelessWidget {
  const StoreItemsPage({required this.store, super.key});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreItemsCubit, StoreItemsState>(
      builder: (context, state) {
        switch (state) {
          case StoreItemsStateLoading():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case StoreItemsStateLoaded(items: final items):
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(store.id.toString()),
              ),
              body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${items[index].id}'),
                    ),
                    title: Text('StoreId:${items[index].storeId}'),
                    subtitle: Text('${items[index].createdAt}'),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<StoreItemsCubit>()
                            .deleteItem(items[index], store);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<StoreItemsCubit>().insertItem(
                        StoreItem(
                          storeId: store.id!,
                          createdAt: DateTime.now(),
                        ),
                        store,
                      );
                },
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}
