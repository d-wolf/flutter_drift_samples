import 'package:drift/drift.dart';
import 'package:drift_self_ref_table/domain/entities/store.dart';

@UseRowClass(Store)
class StoresTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer()
      .nullable()
      .customConstraint('REFERENCES stores_table(id) ON DELETE CASCADE')();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get name => text().withLength(min: 0, max: 50)();
}
