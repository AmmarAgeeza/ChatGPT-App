
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ChatGPT",
            style: TextStyle(
              color: Color(0xff3369FF),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Color(0xff3ABF38),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              SizedBox(width: 6),
              Text(
                "Online",
                style: TextStyle(
                  color: Color(0xff3ABF38),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Image.asset("assets/images/volume-high.png"),
        SizedBox(width: 16),
        Image.asset("assets/images/export.png"),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
