import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:vizmo_app/features/events/data/datasources/event_local_datasource.dart';
import 'package:vizmo_app/features/events/data/datasources/event_remote_datasource.dart';
import 'package:vizmo_app/features/events/data/repositories/event_repository_impl.dart';
import 'package:vizmo_app/features/events/domain/repositories/abstract_event_repository.dart';
import 'package:vizmo_app/features/events/presentation/bloc/events_bloc.dart';

final sl = GetIt.instance;

abstract interface class InjectionBase {
  Future<void> initialise();
}

class Injection implements InjectionBase {
  @override
  Future<void> initialise() async {
    try {
      await initialiseLocators(sl: sl);
    } catch (e) {
      log("Unable to initialise Service Locators due to $e");
    }
  }
}

Future<void> initialiseLocators({required GetIt sl}) async {
  // bloc
  sl.registerLazySingleton(() => EventsBloc(eventRepository: sl()));

  // repository
  sl.registerLazySingleton<AbstractEventRepository>(
    () => EventRepositoryImpl(
      eventRemoteDatasource: sl<AbstractEventRemoteDatasource>(),
      eventLocalDatasource: sl<AbstractEventLocalDatasource>(),
    ),
  );

  // remote data source
  sl.registerLazySingleton<AbstractEventRemoteDatasource>(
      () => EventRemoteDatasourceImpl());

  // local data source
  sl.registerLazySingleton<AbstractEventLocalDatasource>(
      () => EventLocalDatasourceImpl());
}
