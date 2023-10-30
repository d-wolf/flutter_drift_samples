import 'package:drift_self_ref_table/data/datasources/app_database.dart';
import 'package:drift_self_ref_table/data/repositories/store_repository_impl.dart';
import 'package:drift_self_ref_table/domain/repositories/store_repository.dart';
import 'package:drift_self_ref_table/presentation/stores/cubit/stores_cubit.dart';
import 'package:drift_self_ref_table/presentation/stores/page/stores_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // try {
  //   final dbFolder = await getApplicationDocumentsDirectory();
  //   final file = File(p.join(dbFolder.path, 'db.sqlite'));
  //   debugPrint(file.path);
  //   await file.delete();
  // } catch (e) {
  //   debugPrint(e.toString());
  // }

  sl
    ..registerFactory(() => StoresCubit(repo: sl()))
    ..registerLazySingleton<StoreRepository>(() => StoreRepositoryImpl(sl()))
    ..registerLazySingleton(AppDatabase.new);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drift Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StoresPage(),
    );
  }
}
