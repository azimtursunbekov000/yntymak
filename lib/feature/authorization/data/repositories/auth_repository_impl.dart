import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../internal/helpers/api_requester.dart';
import '../../../../internal/helpers/catch_excertion.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/cities_model.dart';
import '../models/login_model.dart';
import '../models/registration_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<LoginModel> login(
      String email, String password, String username) async {
    try {
      var data = {
        'username': username,
        'email': email,
        'password': password,
      };

      await Future.delayed(const Duration(seconds: 2));

      Response response = await apiRequester.toPost(
        'accounts/login/',
        data: data,
      );

      log('Response status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final loginData = LoginModel.fromJson(response.data);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('refreshToken', loginData.tokens['refresh']!);
        await prefs.setString('accessToken', loginData.tokens['access']!);

        return loginData;
      } else {
        throw CatchException.convertException('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Ошибка: $error');
      throw CatchException.convertException(error.toString());
    }
  }

  @override
  Future<RegistrationModel> registration(
      RegistrationModel registrationModel) async {
    try {
      FormData formData = FormData();
      await Future.delayed(const Duration(seconds: 2));

      formData.fields.addAll([
        MapEntry('username', registrationModel.username ?? ''),
        MapEntry('email', registrationModel.email ?? ''),
        MapEntry('password', registrationModel.password ?? ''),
        MapEntry(
            "profile.first_name", registrationModel.profile?.firstName ?? ''),
        MapEntry(
            "profile.last_name", registrationModel.profile?.lastName ?? ''),
        MapEntry(
            "profile.middle_name", registrationModel.profile?.middleName ?? ''),
        MapEntry("profile.phone_number",
            registrationModel.profile?.phoneNumber ?? ''),
        MapEntry("profile.region",
            registrationModel.profile?.region.toString() ?? ''),
        MapEntry("profile.city_or_district",
            registrationModel.profile?.cityOrDistrict.toString() ?? ''),
        MapEntry("profile.position_at_work",
            registrationModel.profile?.positionAtWork ?? ''),
        MapEntry("profile.work_address",
            registrationModel.profile?.workAddress ?? ''),
        MapEntry(
            "profile.work_name", registrationModel.profile?.workName ?? ''),
      ]);

      Response response = await apiRequester.toPost(
        'accounts/registration/',
        data: formData,
      );

      log('Response status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      if (response.statusCode == 201) {
        final registrationData = RegistrationModel.fromJson(response.data);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'refreshToken', response.data['tokens']['refresh']);
        await prefs.setString('accessToken', response.data['tokens']['access']);

        return registrationData;
      } else {
        throw CatchException.convertException('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Ошибка: $error');
      throw CatchException.convertException(error.toString());
    }
  }

  @override
  Future<CitiesModel> getCities() async {
    try {
      Response response = await apiRequester.toGet('cities/');
      log('все города получены ${response.data}');

      await Future.delayed(const Duration(seconds: 2));

      return CitiesModel.fromJson(response.data);
    } catch (e) {
      print('ошибка при получении $e');
      throw CatchException.convertException(e).message.toString();
    }
  }
}
