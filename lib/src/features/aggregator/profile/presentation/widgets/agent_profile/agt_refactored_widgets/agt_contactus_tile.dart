import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AgtContactUsTile extends StatelessWidget {
  const AgtContactUsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AbilityButton(
      onPressed: () {},
      width: 380,
      height: 80,
      borderRadius: 20,
      buttonColor: kWhite,
      borderColor: kWhite,
      child: Row(
        children: [
          const SizedBox(width: 35),
          Container(
            width: 45.25,
            height: 46.00,
            decoration: BoxDecoration(
                color: customColor1,
                borderRadius: BorderRadius.circular(11.31)),
            child: const Icon(Icons.headset_mic, color: kBlack),
          ),
          const SizedBox(width: 18.75),
          Text(
            'Need Help? Contact Us',
            style: AppStyleGilroy.kFontW6.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
