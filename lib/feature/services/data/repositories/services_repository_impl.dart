import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../internal/helpers/api_requester.dart';
import '../../../../internal/helpers/catch_excertion.dart';
import '../../domain/repositories/services_repositories.dart';
import '../models/services_model.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<ServicesModel> getAllServices() async {
    try {
      Response response = await apiRequester.toGet('services/');
      log('все города получены ${response.data}');

      await Future.delayed(const Duration(seconds: 2));

      return ServicesModel.fromJson(response.data);
    } catch (e) {
      print('ошибка при получении $e');
      throw CatchException.convertException(e).message.toString();
    }
  }
}
