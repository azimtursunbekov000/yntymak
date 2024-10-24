import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authorization/data/models/login_model.dart';
import '../../../authorization/data/models/registration_model.dart';

part 'profile__state.dart';

class ProfileCubit extends Cubit<LoginModel?> {
  ProfileCubit() : super(null) {
    _loadProfile();
  }

  void clearProfile() {
    emit(null);
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final username = prefs.getString('username');
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    final phoneNumber = prefs.getString('phoneNumber');
    final positionAtWork = prefs.getString('positionAtWork');
    final qr = prefs.getString('qr_code');
    final workAddress = prefs.getString('workAddress');
    final workName = prefs.getString('workName');
    final id = prefs.getInt('id');
    final password = prefs.getString('password');
    final refresh = prefs.getString('refresh');
    final access = prefs.getString('access');

    if (email != null) {
      emit(
        LoginModel(
          username: username ?? '',
          email: email,
          profile: Profile(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            positionAtWork: positionAtWork,
            qr_code: qr,
            workAddress: workAddress,
            workName: workName,
          ),
          id: id ?? 0,
          password: password ?? '',
          tokens: {
            'refresh': refresh ?? '',
            'access': access ?? '',
          },
        ),
      );
    }
  }

  Future<void> setProfile(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', loginModel.email);
    await prefs.setString('username', loginModel.username);
    await prefs.setString('firstName', loginModel.profile?.firstName ?? '');
    await prefs.setString('lastName', loginModel.profile?.lastName ?? '');
    await prefs.setString('phoneNumber', loginModel.profile?.phoneNumber ?? '');
    await prefs.setString(
        'positionAtWork', loginModel.profile?.positionAtWork ?? '');
    await prefs.setString('qr_code', loginModel.profile?.qr_code ?? '');
    await prefs.setString('workAddress', loginModel.profile?.workAddress ?? '');
    await prefs.setString('workName', loginModel.profile?.workName ?? '');
    await prefs.setString('password', loginModel.password);
    await prefs.setInt('id', loginModel.id);

    emit(loginModel);
  }

  Future<void> updateProfile(RegistrationModel updatedProfile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', updatedProfile.username ?? '');
    await prefs.setString('firstName', updatedProfile.profile?.firstName ?? '');
    await prefs.setString('lastName', updatedProfile.profile?.lastName ?? '');
    await prefs.setString(
        'phoneNumber', updatedProfile.profile?.phoneNumber ?? '');
    await prefs.setString(
        'positionAtWork', updatedProfile.profile?.positionAtWork ?? '');
    await prefs.setString('qr_code', updatedProfile.profile?.qr_code ?? '');
    await prefs.setString(
        'workAddress', updatedProfile.profile?.workAddress ?? '');
    await prefs.setString('workName', updatedProfile.profile?.workName ?? '');

    final currentLoginState = state;
    if (currentLoginState != null) {
      final updatedLoginModel = currentLoginState.copyWith(
        profile: updatedProfile.profile,
      );
      emit(updatedLoginModel);
      await setProfile(updatedLoginModel);
    }
  }
}
