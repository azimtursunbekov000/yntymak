import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../internal/helpers/catch_excertion.dart';
import '../../../../data/models/cities_model.dart';
import '../../../../data/models/login_model.dart';
import '../../../../data/models/registration_model.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc(this.authUseCase) : super(AuthInitialState()) {
    on<PostRegistrationEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          RegistrationModel registrationModel =
              await authUseCase.registration(event.registrationModel);
          emit(RegistrationLoadedState(registrationModel: registrationModel));
        } catch (e) {
          print('error create user $e');
          emit(AuthErrorState(error: CatchException.convertException(e)));
        }
      },
    );

    on<PostAuthorizationEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          LoginModel loginModel = await authUseCase.login(
              event.email, event.password, event.username);
          emit(LoginLoadedState(loginModel: loginModel));
        } catch (e) {
          print('error login user $e');
          emit(AuthErrorState(error: CatchException.convertException(e)));
        }
      },
    );

    on<GetCitiesEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          CitiesModel citiesModel = await authUseCase.getCities();
          emit(CitiesLoadedState(citiesModel: citiesModel));
        } catch (e) {
          print('error fetching cities $e');
          emit(AuthErrorState(error: CatchException.convertException(e)));
        }
      },
    );
  }
}
