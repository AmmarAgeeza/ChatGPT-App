import 'package:chatgpt_app/core/utils/app_color.dart';
import 'package:chatgpt_app/core/utils/app_images.dart';
import 'package:chatgpt_app/core/utils/app_strings.dart';
import 'package:chatgpt_app/features/onboarding/components/continue_button_component.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            //heading Text
            Text(
              AppStrings.youAIAssistant,
              style: TextStyle(
                color: AppColors.primaryColor, //hardcoded
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            //sub title Text
            Text(
              AppStrings
                  .usingThisSoftwareYouCanAskYouQuestionsAndReceiveArticlesUsingArtificialIntelligenceAssistant,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            // Image
            Image.asset(AppImages.onboardingImage),
            Spacer(),
            //continue button
            ContinueButtonComponent(),
          ],
        ),
      ),
    );
  }
}
