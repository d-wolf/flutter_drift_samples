import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/main.dart';
import 'package:flutter_sample_drift/presentation/store_items/cubit/store_items_cubit.dart';
import 'package:flutter_sample_drift/presentation/store_items/page/store_items_page.dart';
import 'package:flutter_sample_drift/presentation/stores/cubit/stores_cubit.dart';
import 'package:flutter_sample_drift/presentation/stores/widgets/store_name_dialog.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCubit, StoresState>(
      builder: (context, state) {
        switch (state) {
          case StoresStateLoading():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case StoresStateLoaded(stores: final stores):
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Stores'),
              ),
              body: ListView.builder(
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
                                .deleteStore(stores[index]);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<StoreItemsPage>(
                          builder: (_) => BlocProvider<StoreItemsCubit>(
                            create: (_) => sl()..init(stores[index]),
                            child: StoreItemsPage(store: stores[index]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
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
                                Store(
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
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}
