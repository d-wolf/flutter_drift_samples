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
  AppDatabase({QueryExecutor? connection})
      : super(connection ?? _openConnection());

  /// Bump version if the tables have changed.
  @override
  int get schemaVersion => 2;

  /// Adabt if db schema has changed.
  ///
  /// Make sure a snapshot of the current schema
  /// has already been created in /drift_shemas.
  /// If not, goto /drift_shemas/README.md and follow
  /// the instructions.
  ///
  /// Steps:
  /// 1. adapt table(s)
  /// 2. bump [schemaVersion]
  /// 3. update codegen by running
  /// `dart run build_runner build --delete-conflicting-outputs`
  /// 4. add an 'onUpgrade' strategy
  /// 5. create new schema snapshot by running
  /// `dart run drift_dev schema dump lib/data/datasources/app_database.dart drift_schemas/`
  /// 6. write a migration test by running
  /// `dart run drift_dev schema generate drift_schemas/ test/generated_migrations/`
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // TextColumn content has been added to store_items_table
          // from schema version 1 to 2.
          await m.addColumn(storeItemsTable, storeItemsTable.content);
        }
      },
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

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return native.NativeDatabase.createInBackground(file);
    });
  }
}
