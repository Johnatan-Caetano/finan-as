import 'package:financy_app/common/constants/constants.dart';
import 'package:financy_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class CheckYourEmailPage extends StatelessWidget {
  const CheckYourEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: ListView(
          children: [
            Text(
              'Redefinir sua\nSenha',
              textAlign: TextAlign.center,
              style: AppTextStyles.mediumText36.copyWith(
                color: AppColors.greenOne,
              ),
            ),
            Image.asset('assets/images/check_your_email_image.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Tudo pronto! Siga as instruções no seu e-mail para redefinir sua senha. Não esqueça de verificar a caixa de spam!",
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText16w500.copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            PrimaryButton(
                text: 'Login',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      NamedRoute.signIn,
                      ModalRoute.withName(NamedRoute.initial),
                    )),
          ],
        ),
      ),
    );
  }
}
