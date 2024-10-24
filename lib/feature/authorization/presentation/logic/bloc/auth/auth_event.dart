part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class PostRegistrationEvent extends AuthEvent {
  final RegistrationModel registrationModel;

  PostRegistrationEvent({required this.registrationModel});
}

class PostAuthorizationEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  PostAuthorizationEvent( {
    required this.username,
    required this.email,
    required this.password,
  });
}

class GetCitiesEvent extends AuthEvent {}
