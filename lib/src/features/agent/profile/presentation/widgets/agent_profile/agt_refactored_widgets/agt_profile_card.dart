import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/upload_photo_bsheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class AgtProfileCard extends ConsumerWidget {
  const AgtProfileCard({
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
          Stack(
            children: [
              ClipOval(
                child: InkWell(
                  onTap: () {
                    uploadPhotoBottomSheet(context, ref);
                  },
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: agtProfile.when(
                      data: (data) {
                        var profilePhoto = data.data.data.profilePicture;
                        return NetworkImage(
                          profilePhoto,
                        );
                      },
                      error: (e, s) => const NetworkImage(''),
                      loading: () => null,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    uploadPhotoBottomSheet(context, ref);
                  },
                  child: const Icon(
                    Iconsax.camera4,
                    color: kWhite,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15.48),
          agtProfile.when(
              data: (data) {
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
