import 'package:chatgpt_app/core/database/cache/cache_helper.dart';
import 'package:chatgpt_app/core/utils/app_color.dart';
import 'package:chatgpt_app/core/utils/app_strings.dart';
import 'package:chatgpt_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../home/views/screens/home_screen.dart';

class ContinueButtonComponent extends StatelessWidget {
  const ContinueButtonComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 0),
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        CacheHelper.saveData(key: "onboarding", value: true).then((
          value,
        ) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          }
        });
      },
      child: ListTile(
        title: Center(
          child: Text(
            AppStrings.continueButton,
            style: AppStyles.bold18,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
