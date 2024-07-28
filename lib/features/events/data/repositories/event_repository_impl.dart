import 'package:dartz/dartz.dart';
import 'package:vizmo_app/core/error/failure.dart';
import 'package:vizmo_app/features/events/data/datasources/event_local_datasource.dart';
import 'package:vizmo_app/features/events/data/datasources/event_remote_datasource.dart';
import 'package:vizmo_app/features/events/data/models/vizmo_event_model.dart';
import 'package:vizmo_app/features/events/domain/repositories/abstract_event_repository.dart';

class EventRepositoryImpl implements AbstractEventRepository {
  final AbstractEventRemoteDatasource eventRemoteDatasource;
  final AbstractEventLocalDatasource eventLocalDatasource;

  EventRepositoryImpl({
    required this.eventRemoteDatasource,
    required this.eventLocalDatasource,
  });

  @override
  Future<Either<Failure, void>> fetchAllAndDump() async {
    try {
      final bool hasData = await eventLocalDatasource.hasEventsData();

      if (hasData == false) {
        final resultFromRemote = await eventRemoteDatasource.fetchEvents();

        await eventLocalDatasource.dumpEvents(vizoEventModel: resultFromRemote);
      }
      return const Right(null);
    } on StorageFailure catch (e) {
      throw Left(StorageFailure(errorMessage: e.errorMessage));
    } catch (e) {
      throw Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VizmoEventsModel>> fetchEventsPerDay(
      {required String? targetDate}) async {
    try {
      final resultFromLocal =
          await eventLocalDatasource.fetchEventsPerDay(targetDate: targetDate);

      return Right(resultFromLocal);
    } on StorageFailure catch (e) {
      throw Left(StorageFailure(errorMessage: e.errorMessage));
    } catch (e) {
      throw Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
