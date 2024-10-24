import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/profile__cubit.dart';

class QrCard extends StatelessWidget {
  const QrCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileModel = context.watch<ProfileCubit>().state;
    const String baseUrl = 'https://yntymak.kg';
    final String? qrCodePath = profileModel?.profile?.qr_code;
    final String qrCodeUrl = qrCodePath != null ? baseUrl + qrCodePath : '';

    print('qr code path: $qrCodePath');
    print('qr code url: $qrCodeUrl');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Card(
            elevation: 20,
            color: Colors.white,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                qrCodeUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
