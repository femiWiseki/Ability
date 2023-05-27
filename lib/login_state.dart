// import 'package:flutter/material.dart';


// // ignore: must_be_immutable
// class LoginState extends StatefulWidget {
//   const LoginState({Key? key}) : super(key: key);

//   @override
//   State<LoginState> createState() => _LoginStateState();
// }

// class _LoginStateState extends State<LoginState> {
//   int? initLoginScreen;

//   @override
//   void initState() {
//     _checkLoginState();
//     super.initState();
//   }

//   void _checkLoginState() async {
//     await Future.delayed(const Duration(milliseconds: 500), () {});
//     UserPreference.getId() == null

//         // ignore: use_build_context_synchronously
//         ? PageNavigator(ctx: context)
//             .nextPageRep(page: Login(ValidationHelper()))

//         // ignore: use_build_context_synchronously
//         : PageNavigator(ctx: context)
//             .nextPageRep(page: VerifyLogin(ValidationHelper()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
