import 'package:chatgpt_app/core/database/cache/cache_helper.dart';
import 'package:chatgpt_app/core/utils/app_color.dart';
import 'package:chatgpt_app/features/chat/ui/screens/ai_chat_screen.dart';
import 'package:chatgpt_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        fontFamily: "Nunito",
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CacheHelper.getData(key: "onboarding") != null
          ? AiChatScreen()
          : OnboardingScreen(),
    );
  }
}
