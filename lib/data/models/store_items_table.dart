import 'package:drift/drift.dart';
// needed for codegen
// ignore: unused_import
import 'package:flutter_sample_drift/data/models/stores_table.dart';
import 'package:flutter_sample_drift/domain/entities/store_item.dart';

@UseRowClass(StoreItem)
class StoreItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().customConstraint(
        'NOT NULL REFERENCES stores_table(id) ON DELETE CASCADE',
      )();
  DateTimeColumn get createdAt => dateTime()();

  /// new, added column in v2
  TextColumn get content => text()();
}
