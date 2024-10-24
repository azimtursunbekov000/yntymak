import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yntymak/feature/profile/presentation/screens/qr_code.dart';

import '../../../../internal/commons/common_elevated_button.dart';
import '../logic/profile__cubit.dart';
import '../logic/theme_cubit.dart';
import '../widget/profile_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showQRCode = false;

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    context.read<ProfileCubit>().clearProfile();

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;

    final bool isUserRegistered = profileState?.profile != null;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: isUserRegistered
          ? Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(child: ProfileDataWidget()),
                          ],
                        ),
                        const SizedBox(height: 50),
                        CommonElevatedButton(
                          title: 'Телефонный справочник',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 16),
                        CommonElevatedButton(
                          title: 'СМИ',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 16),
                        CommonElevatedButton(
                          title: 'Поменять тему',
                          onPressed: () {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                        ),
                        const SizedBox(height: 50),
                        CommonElevatedButton(
                          title: 'Показать QR',
                          onPressed: () {
                            setState(() {
                              showQRCode = true;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                if (showQRCode)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showQRCode = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.5),
                      child: const QrCard(),
                    ),
                  ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CommonElevatedButton(
                      title: 'Пройдите регистрацию',
                      onPressed: () {
                        context.go('/auth');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: CommonElevatedButton(
                      title: 'Войти',
                      onPressed: () {
                        context.go('/auth');
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
