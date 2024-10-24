part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class RegistrationLoadedState extends AuthState {
  final RegistrationModel registrationModel;

  RegistrationLoadedState({required this.registrationModel});
}

final class RegistrationErrorState extends AuthState {
  final CatchException error;

  RegistrationErrorState({required this.error});

}

final class LoginLoadedState extends AuthState{
  final LoginModel loginModel;

  LoginLoadedState({required this.loginModel});
}

final class AuthErrorState extends AuthState {
  final CatchException error;

  AuthErrorState({required this.error});
}


final class CitiesLoadedState extends AuthState{
  final CitiesModel citiesModel;

  CitiesLoadedState({required this.citiesModel});
}



