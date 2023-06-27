import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/home/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggProfileCard extends ConsumerWidget {
  const AggProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agtProfile = ref.watch(getAgtProfileProvider);

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
          agtProfile.when(
              data: (data) {
                print(data.data.data.name);
                return Text(
                  data.data.data.name,
                  style: AppStyleGilroy.kFontW6
                      .copyWith(fontSize: 18.64, color: kWhite),
                );
              },
              error: (e, s) => Text(e.toString()),
              loading: () => const Text('.....')),
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
