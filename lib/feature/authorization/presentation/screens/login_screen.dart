import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../internal/commons/common_elevated_button.dart';
import '../../../../internal/commons/common_text_field_widget.dart';
import '../../../../internal/theme/theme_helper.dart';
import '../../../profile/presentation/logic/profile__cubit.dart';
import '../../data/models/login_model.dart';
import '../../data/models/registration_model.dart';
import '../logic/bloc/auth/auth_bloc.dart';
import '../widget/drop_down_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController(text: '996');
  final TextEditingController regionController = TextEditingController();
  final TextEditingController cityOrDistrictController =
      TextEditingController();
  final TextEditingController positionAtWorkController =
      TextEditingController();
  final TextEditingController workAddressController = TextEditingController();
  final TextEditingController workNameController = TextEditingController();

  bool isRegistrationFields = false;
  bool showError = false;

  int selectedRegionIndex = -1;
  int selectedAreaIndex = -1;

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveLoginInfo(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', loginModel.username);
    await prefs.setString('email', loginModel.email);
    await prefs.setString('firstName', loginModel.profile?.firstName ?? '');
    await prefs.setString('lastName', loginModel.profile?.lastName ?? '');
    await prefs.setString('phoneNumber', loginModel.profile?.phoneNumber ?? '');
    await prefs.setString('qr_code', loginModel.profile?.qr_code ?? '');
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('email');
  }

  void _checkLoginStatus() async {
    if (await _isLoggedIn()) {
      context.replace('/');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  final Map<String, int> regionIds = {
    'Чуйская': 1,
    'Ошская': 2,
    'Талаская': 3,
    'Нарынская': 4,
    'Баткенская': 5,
    'Иссык-Кульская': 6,
    'Жалал-Абадская': 7,
  };

  final Map<String, int> cityOrDistrictIds = {
    'Чуй': 1,
    'Бишкек': 2,
    'Ош': 3,
    'Ноокат': 4,
    'Токмок': 5,
    'Кара-Балта': 6,
    'Чолпон-Ата': 7,
    'Балыкчы': 8,
    'Каракол': 9,
    'Тюпский район': 10,
    'Ак-Суйский район': 11,
    'Тонский  район': 12,
    'Джети-Огузский  район': 13,
    'Иссык-Кульский  район': 14,
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: ThemeHelper.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: BlocConsumer<AuthBloc, AuthState>(
                  bloc: context.read<AuthBloc>(),
                  listener: (context, state) async {
                    if (state is AuthErrorState) {
                      // Обработка ошибок
                    } else if (state is RegistrationLoadedState) {
                      setState(() {
                        isRegistrationFields = !isRegistrationFields;
                      }); // Заменяем текущий экран на главный экран (BottomNavBar)
                    } else if (state is LoginLoadedState) {
                      await _saveLoginInfo(state.loginModel);
                      context.read<ProfileCubit>().setProfile(state.loginModel);
                      context.replace(
                          '/'); // Перенаправляем на главный экран с BottomNavBar
                    } else if (state is RegistrationErrorState) {
                      // Обработка ошибок регистрации
                      try {
                        final Map<String, dynamic> errorMessage = json.decode(
                            state.error.message ?? 'что-то пошло не так');

                        if (errorMessage.containsKey('email')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Этот email уже зарегистрирован'),
                            ),
                          );
                        } else if (errorMessage.containsKey('profile')) {
                          final profileErrors = errorMessage['profile'];
                          if (profileErrors.containsKey('phone_number')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Этот номер телефона уже зарегистрирован'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Ошибка регистрации: ${state.error.message ?? ''}',
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ошибка обработки сообщения об ошибке: ${state.error.message ?? ''}',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const CircularProgressIndicator();
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 200,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                            labelText: 'userName',
                            controller: userNameController,
                            showError:
                                showError && (userNameController.text.isEmpty),
                          ),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                            labelText: 'Почта',
                            controller: emailController,
                            hintText: 'user.example@gmail.com',
                            showError: showError &&
                                (emailController.text.isEmpty ||
                                    passwordController.text.isEmpty),
                          ),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                            labelText: 'Пароль',
                            controller: passwordController,
                            showError: showError &&
                                (emailController.text.isEmpty ||
                                    passwordController.text.isEmpty),
                          ),
                          CommonTextFieldWidget(
                            labelText: 'Повторить пароль',
                            controller: repeatPasswordController,
                            showError: showError &&
                                (emailController.text.isEmpty ||
                                    passwordController.text.isEmpty),
                          ),
                          if (isRegistrationFields) ...[
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                              labelText: 'Имя',
                              controller: firstNameController,
                              showError: showError &&
                                  (firstNameController.text.isEmpty ||
                                      lastNameController.text.isEmpty),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextFieldWidget(
                                    labelText: 'Фамилия',
                                    controller: lastNameController,
                                    showError: showError &&
                                        (firstNameController.text.isEmpty ||
                                            lastNameController.text.isEmpty),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: CommonTextFieldWidget(
                                    labelText: 'Отчество',
                                    controller: middleNameController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                              labelText: 'Номер телефона',
                              controller: phoneNumberController,
                              showError: showError &&
                                  (phoneNumberController.text.isEmpty),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextFieldWidget(
                                    isBorder: true,
                                    labelText: 'Регион',
                                    controller: regionController,
                                    showError: showError &&
                                        (regionController.text.isEmpty),
                                    suffixIcon: DropDownMenuWidget(
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedRegionIndex =
                                              regionIds[value ?? ''] ?? -1;
                                          regionController.text = value ?? '';
                                        });
                                      },
                                      options: regionIds.keys.toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: CommonTextFieldWidget(
                                    isBorder: true,
                                    labelText: 'Район',
                                    controller: cityOrDistrictController,
                                    showError: showError &&
                                        (cityOrDistrictController.text.isEmpty),
                                    suffixIcon: DropDownMenuWidget(
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedAreaIndex =
                                              cityOrDistrictIds[value ?? ''] ??
                                                  -1;
                                          cityOrDistrictController.text =
                                              value ?? '';
                                        });
                                      },
                                      options: cityOrDistrictIds.keys.toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                              labelText: 'Место работы',
                              controller: positionAtWorkController,
                              showError: showError &&
                                  (positionAtWorkController.text.isEmpty),
                            ),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                              labelText: 'Рабочий адрес',
                              controller: workAddressController,
                              showError: showError &&
                                  (workAddressController.text.isEmpty),
                            ),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                              labelText: 'Название работы',
                              controller: workNameController,
                              showError: showError &&
                                  (workNameController.text.isEmpty),
                            ),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 20),
                          CommonElevatedButton(
                            title: isRegistrationFields
                                ? 'Зарегистрироваться'
                                : 'Войти',
                            onPressed: () {
                              setState(() {
                                showError = true;
                              });

                              if (!showError) return;

                              if (isRegistrationFields) {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  final registrationModel = RegistrationModel(
                                    username: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    repeatPassword:
                                        repeatPasswordController.text,
                                    profile: Profile(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      middleName: middleNameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      region: selectedRegionIndex,
                                      cityOrDistrict: selectedAreaIndex,
                                      positionAtWork:
                                          positionAtWorkController.text,
                                      workAddress: workAddressController.text,
                                      workName: workNameController.text,
                                    ),
                                  );
                                  print(
                                      'Registration Model: ${registrationModel.toJson()}');

                                  if (_areAllRegistrationFieldsFilled(
                                      registrationModel)) {
                                    context.read<AuthBloc>().add(
                                          PostRegistrationEvent(
                                            registrationModel:
                                                registrationModel,
                                          ),
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Заполните все обязательные поля',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthBloc>().add(
                                        PostAuthorizationEvent(
                                          username: userNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          CommonElevatedButton(
                            title:
                                isRegistrationFields ? 'Отмена' : 'Регистрация',
                            onPressed: () {
                              setState(() {
                                isRegistrationFields = !isRegistrationFields;
                                showError = false;
                              });
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _areAllRegistrationFieldsFilled(RegistrationModel model) {
    return model.username?.isNotEmpty == true &&
        model.email?.isNotEmpty == true &&
        model.password?.isNotEmpty == true &&
        model.repeatPassword?.isNotEmpty == true &&
        model.profile?.firstName?.isNotEmpty == true &&
        model.profile?.lastName?.isNotEmpty == true &&
        model.profile?.phoneNumber?.isNotEmpty == true &&
        model.profile?.region != null &&
        model.profile?.cityOrDistrict != null &&
        model.profile?.positionAtWork?.isNotEmpty == true &&
        model.profile?.workAddress?.isNotEmpty == true &&
        model.profile?.workName?.isNotEmpty == true;
  }
}
