import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_drift/data/datasources/app_database.dart';
import 'package:flutter_sample_drift/data/repositories/store_repository_impl.dart';
import 'package:flutter_sample_drift/domain/repositories/store_repository.dart';
import 'package:flutter_sample_drift/presentation/store_items/cubit/store_items_cubit.dart';
import 'package:flutter_sample_drift/presentation/stores/cubit/stores_cubit.dart';
import 'package:flutter_sample_drift/presentation/stores/page/stores_page.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  sl
    ..registerFactory(() => StoresCubit(repo: sl()))
    ..registerFactory(() => StoreItemsCubit(repo: sl()))
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
      home: BlocProvider<StoresCubit>(
        create: (_) => sl()..init(),
        child: const StoresPage(),
      ),
    );
  }
}
