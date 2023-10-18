import 'package:drift/drift.dart';
import 'package:flutter_sample_drift/domain/entities/store.dart';

@UseRowClass(Store)
class StoresTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get name => text().withLength(min: 0, max: 50)();
}
