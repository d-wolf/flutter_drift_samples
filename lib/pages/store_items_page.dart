import 'package:flutter/material.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';
import 'package:flutter_sample_drift/main.dart';

class StoreItemsPage extends StatefulWidget {
  const StoreItemsPage({required this.store, super.key});

  final Store store;

  @override
  State<StoreItemsPage> createState() => _StoreItemsPageState();
}

class _StoreItemsPageState extends State<StoreItemsPage> {
  final _repo = sl<StoreRepository>();
  final _list = <StoreItem>[];

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
        title: Text(widget.store.id.toString()),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${_list[index].id}'),
            ),
            title: Text('Store:${_list[index].storeId}'),
            subtitle: Text('${_list[index].createdAt}'),
            trailing: IconButton(
              onPressed: () async {
                final point = _list[index];
                await _repo.deletePoint(point);
                await _reload();
              },
              icon: const Icon(Icons.delete),
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _repo.insertPoint(
              StoreItem(storeId: widget.store.id!, createdAt: DateTime.now()),
              widget.store,
            );
          } catch (e) {
            debugPrint(e.toString());
          }

          await _reload();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _reload() async {
    final items = await _repo.getPointsForStore(widget.store);

    setState(() {
      _list
        ..clear()
        ..addAll(items);
    });
  }
}
