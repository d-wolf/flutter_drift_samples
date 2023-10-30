import 'package:drift_self_ref_table/domain/entities/store.dart';
import 'package:drift_self_ref_table/domain/entities/store_item.dart';
import 'package:drift_self_ref_table/main.dart';
// import 'package:drift_self_ref_table/main.dart';
// import 'package:drift_self_ref_table/presentation/store_items/cubit/store_items_cubit.dart';
// import 'package:drift_self_ref_table/presentation/store_items/page/store_items_page.dart';
import 'package:drift_self_ref_table/presentation/stores/cubit/stores_cubit.dart';
import 'package:drift_self_ref_table/presentation/stores/widgets/store_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({this.chain = const [], this.store, super.key});
  final List<String> chain;
  final Store? store;

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoresCubit>(
      create: (_) => sl()..init(widget.store),
      child: BlocBuilder<StoresCubit, StoresState>(
        builder: (context, state) {
          switch (state) {
            case StoresStateLoading():
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case StoresStateLoaded(stores: final stores, items: final items):
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text(
                    widget.chain.isEmpty
                        ? 'root'
                        : widget.chain
                            .reduce((value, element) => '$value > $element'),
                  ),
                ),
                body: stores.isNotEmpty
                    ? _buildStoresList(context, stores)
                    : _buildItemsList(context, items),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _addStore(context, items),
                    const SizedBox(
                      height: 12,
                    ),
                    _addItem(context, stores),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  Widget _buildStoresList(BuildContext context, List<Store> stores) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${stores[index].id}')),
          title: Text(stores[index].name),
          subtitle: Text('${stores[index].createdAt}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  _textEditingController.text = stores[index].name;
                  await showDialog<AlertDialog>(
                    context: context,
                    builder: (_) {
                      return StoreNameDialog(
                        textEditingController: _textEditingController,
                        onOk: () {
                          Navigator.of(context).pop();
                          context.read<StoresCubit>().updateStore(
                                widget.store,
                                Store(
                                  id: stores[index].id,
                                  createdAt: stores[index].createdAt,
                                  name: _textEditingController.text,
                                ),
                              );
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<StoresCubit>()
                      .deleteStore(widget.store, stores[index]);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<StoresPage>(
                builder: (_) => StoresPage(
                  key: ValueKey(stores[index].id),
                  chain: List.from(widget.chain)..add(stores[index].name),
                  store: stores[index],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItemsList(BuildContext context, List<StoreItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text('${items[index].id}'),
          ),
          title: Text('Store:${items[index].storeId}'),
          subtitle: Text('${items[index].createdAt}'),
          trailing: IconButton(
            onPressed: () async {
              await context
                  .read<StoresCubit>()
                  .deleteItem(widget.store!, items[index]);
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: () {},
        );
      },
    );
  }

  Widget _addStore(BuildContext context, List<StoreItem> items) {
    return items.isEmpty
        ? FloatingActionButton(
            heroTag: 'h1',
            onPressed: () async {
              _textEditingController.clear();
              await showDialog<AlertDialog>(
                context: context,
                builder: (_) {
                  return StoreNameDialog(
                    textEditingController: _textEditingController,
                    onOk: () {
                      Navigator.of(context).pop();
                      context.read<StoresCubit>().insertStore(
                            widget.store,
                            Store(
                              storeId: widget.store?.id,
                              createdAt: DateTime.now(),
                              name: _textEditingController.text,
                            ),
                          );
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
            tooltip: 'Add store',
            child: const Icon(Icons.add),
          )
        : const SizedBox();
  }

  Widget _addItem(BuildContext context, List<Store> stores) {
    return widget.store != null && stores.isEmpty
        ? FloatingActionButton(
            heroTag: 'h2',
            onPressed: () async {
              await context.read<StoresCubit>().insertItem(
                    widget.store!,
                    StoreItem(
                      storeId: widget.store!.id!,
                      createdAt: DateTime.now(),
                    ),
                  );
            },
            tooltip: 'Add item',
            child: const Icon(Icons.add),
          )
        : const SizedBox();
  }
}
