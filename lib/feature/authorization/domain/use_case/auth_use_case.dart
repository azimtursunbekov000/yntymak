import '../../data/models/cities_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/registration_model.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<LoginModel> login(
      String email, String password, String username) async {
    return await authRepository.login(email, password, username);
  }

  Future<RegistrationModel> registration(
      RegistrationModel registrationModel) async {
    return await authRepository.registration(registrationModel);
  }

  Future<CitiesModel> getCities() async {
    return await authRepository.getCities();
  }
}
