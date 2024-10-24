import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../internal/theme/text_helper.dart';
import '../logic/profile__cubit.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileModel = context.watch<ProfileCubit>().state;

    final isRegistered = profileModel?.profile != null;

    return isRegistered
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Имя:'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      profileModel?.profile?.firstName ?? '',
                      style: TextHelper.poppins14w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Фамилия:'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      profileModel?.profile?.lastName ?? '',
                      style: TextHelper.poppins14w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Должность:'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      profileModel?.profile?.positionAtWork ??
                          'Должность не указана',
                      style: TextHelper.poppins14w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Номер телефона:'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      profileModel?.profile?.phoneNumber ?? 'номер не указан',
                      style: TextHelper.poppins14w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Почта:'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      profileModel?.email ?? '',
                      style: TextHelper.poppins14w700,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: Text(
              'Пожалуйста, пройдите регистрацию.',
              style: TextHelper.poppins14w700,
            ),
          );
  }
}
