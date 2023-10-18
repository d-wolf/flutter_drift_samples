import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart' as native;
import 'package:flutter_sample_drift/data/models/store_items_table.dart';
import 'package:flutter_sample_drift/data/models/stores_table.dart';
// ignore: unused_import
import 'package:flutter_sample_drift/domain/entities/store.dart';
// ignore: unused_import
import 'package:flutter_sample_drift/domain/entities/store_item.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [StoresTable, StoreItemsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<void> deleteDb() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    await file.delete();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return native.NativeDatabase.createInBackground(file);
  });
}
