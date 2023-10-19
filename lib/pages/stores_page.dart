import 'package:flutter/material.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';
import 'package:flutter_sample_drift/main.dart';
import 'package:flutter_sample_drift/pages/store_items_page.dart';
import 'package:flutter_sample_drift/widgets/store_name_dialog.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final _repo = sl<StoreRepository>();
  final _textEditingController = TextEditingController();
  final _list = <Store>[];

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stores'),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${_list[index].id}')),
            title: Text(_list[index].name),
            subtitle: Text('${_list[index].createdAt}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    _textEditingController.text = _list[index].name;
                    await showDialog<AlertDialog>(
                      context: context,
                      builder: (BuildContext context) {
                        return StoreNameDialog(
                          textEditingController: _textEditingController,
                          onOk: () async {
                            await _repo
                                .updateStore(
                                  Store(
                                    id: _list[index].id,
                                    createdAt: _list[index].createdAt,
                                    name: _textEditingController.text,
                                  ),
                                )
                                .then((value) => Navigator.of(context).pop());
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                    await _reload();
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    final store = _list[index];
                    await _repo.deleteStore(store);
                    final all = await _repo.getPointsForStore(store);
                    // any items left?
                    debugPrint('leftover: $all');
                    await _reload();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<StoreItemsPage>(
                  builder: (_) => StoreItemsPage(store: _list[index]),
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
            builder: (BuildContext context) {
              return StoreNameDialog(
                textEditingController: _textEditingController,
                onOk: () async {
                  await _repo
                      .insertStore(
                        Store(
                          createdAt: DateTime.now(),
                          name: _textEditingController.text,
                        ),
                      )
                      .then((value) => Navigator.of(context).pop());
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
          await _reload();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _reload() async {
    final items = await _repo.getAllStores();

    setState(() {
      _list
        ..clear()
        ..addAll(items);
    });
  }
}
