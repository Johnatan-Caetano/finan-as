import 'package:flutter/material.dart';

import '../../common/constants/constants.dart';
import '../../common/widgets/widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.antiFlashWhite,
      body: Column(
        children: [
          const SizedBox(height: 48.0),
          Expanded(
            child: Image.asset(
              'assets/images/onboarding_image.png',
            ),
          ),
          Text(
            'Gaste de forma inteligente',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText30.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          Text(
            'Economize mais',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText30.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              key: Keys.onboardingGetStartedButton,
              text: 'Comece aqui',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.signUp,
                );
              },
            ),
          ),
          MultiTextButton(
            key: Keys.onboardingAlreadyHaveAccountButton,
            onPressed: () => Navigator.pushNamed(context, NamedRoute.signIn),
            children: [
              Text(
                'Já possui uma conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entre aqui ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.darkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
