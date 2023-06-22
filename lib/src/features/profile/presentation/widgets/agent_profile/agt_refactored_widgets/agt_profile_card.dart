import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AgtProfileCard extends StatelessWidget {
  const AgtProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 267.38,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/profile_frame.png'),
            fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32.67),
          const ClipOval(
            child: CircleAvatar(
              radius: 44,
            ),
          ),
          const SizedBox(height: 15.48),
          Text(
            'Ajao Afeez',
            style:
                AppStyleGilroy.kFontW6.copyWith(fontSize: 18.64, color: kWhite),
          ),
          const SizedBox(height: 25.98),
          AbilityButton(
            onPressed: () {},
            width: 314.66,
            height: 47.29,
            borderRadius: 12.9,
            title: 'Edit Profile',
          )
        ],
      ),
    );
  }
}
