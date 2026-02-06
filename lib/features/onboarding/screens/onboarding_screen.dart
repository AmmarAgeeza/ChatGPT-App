import 'package:flutter/material.dart';

import '../../home/views/screens/home_screen.dart';

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
              "You AI Assistant",
              style: TextStyle(
                color: Color(0xff3369FF),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            //sub title Text
            Text(
              """Using this software,you can ask you questions and receive articles using artificial intelligence assistant""",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            // Image
            Image.asset("assets/images/onboarding_image.png"),
            Spacer(),
            //continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 0),
                backgroundColor: Color(0xff3369FF),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
              child: ListTile(
                title: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
