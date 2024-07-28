import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vizmo_app/core/error/failure.dart';
import 'package:vizmo_app/features/events/data/models/vizmo_event_model.dart';

abstract interface class AbstractEventRemoteDatasource {
  Future<VizmoEventsModel> fetchEvents();
}

class EventRemoteDatasourceImpl implements AbstractEventRemoteDatasource {
  @override
  Future<VizmoEventsModel> fetchEvents() async {
    try {
      final Dio dio = Dio();
      String bearerToken = '2f68dbbf-519d-4f01-9636-e2421b68f379';
      final Response result = await dio.get(
        "https://mock.apidog.com/m1/561191-524377-default/Event",
        options: Options(
          headers: {"Authorization": 'Bearer $bearerToken'},
        ),
      );

      if (result.statusCode == 200) {
        return VizmoEventsModel.fromJson(jsonDecode(result.data));
      } else {
        throw const ServerFailure(
            errorMessage: "Something Went Wrong, Please Try again later");
      }
    } catch (e) {
      rethrow;
    }
  }
}
