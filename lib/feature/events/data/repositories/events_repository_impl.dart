import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../internal/helpers/api_requester.dart';
import '../../../../internal/helpers/catch_excertion.dart';
import '../../domain/repositories/events_repository.dart';
import '../models/events_model.dart';

class EventsRepositoryImpl implements NewsRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<EventsModel> getAllNews() async {
    try {
      Response response = await apiRequester.toGet('news');
      log('getAllNews result == ${response.data}');

      return EventsModel.fromJson(response.data);
    } catch (e) {
      print('error $e');
      throw CatchException.convertException(e);
    }
  }

  Future<Result> getEventById(String? eventId) async {
    try {
      if (eventId == null) {
        throw Exception("Event ID is null");
      }

      Response response = await apiRequester.toGet('news/$eventId');
      log('getEventById result == ${response.data}');

      return Result.fromJson(response.data);
    } catch (e) {
      log('error $e');
      throw CatchException.convertException(e);
    }
  }
}
