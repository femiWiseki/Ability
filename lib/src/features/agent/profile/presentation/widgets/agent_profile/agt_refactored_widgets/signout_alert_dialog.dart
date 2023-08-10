import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';

signoutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Column(
          children: [
            const Icon(
              Icons.logout_outlined,
              size: 60,
              color: kRed,
            ),
            const SizedBox(height: 10),
            Text(
              'Are you sure you want to sign out?',
              style:
                  AppStyleRoboto.kFontW7.copyWith(fontSize: 16, color: kBlack),
            ),
            const SizedBox(height: 10),
            Text(
              'Please confirm if you want to sign out of your account. This action will log you out and you will need to sign in again to access your account.',
              textAlign: TextAlign.center,
              style:
                  AppStyleRoboto.kFontW4.copyWith(color: kGrey2, fontSize: 13),
            ),
            const SizedBox(height: 30),
            AbilityButton(
              onPressed: () {
                AgentPreference.logoutUser().then((value) {
                  PageNavigator(ctx: context).nextPageOnly(
                      page: AgentLoginScreen(
                          ValidationHelper(), AgentController()));
                });
              },
              title: 'Sign me Out',
              buttonColor: kRed,
              borderColor: kRed,
            ),
            const SizedBox(height: 10),
            AbilityButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Close',
              buttonColor: kGrey3,
              borderColor: kGrey3,
            )
          ],
        ),
      );
    },
  );
}

// Delete Account
// deleteAccountDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         title: Column(
//           children: [
//             const Icon(
//               Iconsax.profile_delete,
//               size: 80,
//               color: kRed,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Confirm account Deletion',
//               style:
//                   AppStyleRoboto.kFontW6.copyWith(fontSize: 16, color: kBlack),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'By deleting your account you loose all your\nSubpadi data and infomation.',
//               textAlign: TextAlign.center,
//               style:
//                   AppStyleRoboto.kFontW4.copyWith(color: kGrey2, fontSize: 13),
//             ),
//             const SizedBox(height: 30),
//             Consumer(
//               builder: (context, ref, child) {
//                 return GeneralButton(
//                   onPressed: () async {
//                     await ref
//                         .watch(loadingDeleteAccount.notifier)
//                         .deleteAccService(context: context);
//                   },
//                   title: 'Delete my account',
//                   buttonColor: kRed,
//                   borderColor: kRed,
//                   child: !ref.watch(loadingDeleteAccount)
//                       ? Text(
//                           'Delete Account',
//                           style: AppStyleRoboto.kFontW7
//                               .copyWith(color: kWhite, fontSize: 14),
//                         )
//                       : const Center(
//                           child: SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 6,
//                               color: kWhite,
//                               backgroundColor: kBlack,
//                             ),
//                           ),
//                         ),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             GeneralButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               title: 'Close',
//               buttonColor: kGrey3,
//               borderColor: kGrey3,
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
