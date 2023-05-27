// import 'package:flutter/material.dart';


// // ignore: must_be_immutable
// class UserState extends StatefulWidget {
//   const UserState({Key? key}) : super(key: key);

//   @override
//   State<UserState> createState() => _UserStateState();
// }

// class _UserStateState extends State<UserState> {
//   // LoginService loginService = LoginService();

//   @override
//   void initState() {
//     _checkUserState();
//     super.initState();
//   }

//   void _checkUserState() async {
//     await Future.delayed(const Duration(milliseconds: 500), () {});
//     UserPreference.getAccessToken() == null

//         // ignore: use_build_context_synchronously
//         ? PageNavigator(ctx: context).nextPageOnly(page: const GetStarted())

//         // ignore: use_build_context_synchronously
//         : PageNavigator(ctx: context).nextPageOnly(page: const Home());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
