import 'package:dartz/dartz.dart';
import 'package:vizmo_app/core/error/failure.dart';
import 'package:vizmo_app/features/events/data/models/vizmo_event_model.dart';

abstract interface class AbstractEventRepository {
  Future<Either<Failure, void>> fetchAllAndDump();

  Future<Either<Failure, VizmoEventsModel>> fetchEventsPerDay(
      {required String? targetDate});
}
