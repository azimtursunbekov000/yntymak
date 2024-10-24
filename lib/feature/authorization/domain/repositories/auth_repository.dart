import '../../data/models/cities_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/registration_model.dart';

abstract class AuthRepository {
  /// запрос для логина
  Future<LoginModel> login(String email, String password, String username);

  /// запрос для регистрации
  Future<RegistrationModel> registration(RegistrationModel registrationModel);

  /// запрос для получения городов

  Future<CitiesModel> getCities();
}
