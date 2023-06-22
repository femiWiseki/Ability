// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/home/presentation/controllers/home_controllers.dart';
import 'package:ability/src/features/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/home/presentation/widgets/aggregator_home/agg_bottom_nav_bar.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/currency_editing_controller.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/show_alert_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggEnterAmount extends ConsumerStatefulWidget {
  HomeControllers homeControllers;
  AggEnterAmount(this.homeControllers, {super.key});

  @override
  ConsumerState<AggEnterAmount> createState() => _AggEnterAmount();
}

class _AggEnterAmount extends ConsumerState<AggEnterAmount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _checked = false;
  var publicKey = 'pk_test_ff5cf326e94c37944f34693bc685030cd16e5411';
  final plugin = PaystackPlugin();
  String message = '';

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: publicKey);

    widget.homeControllers.walletAmount = CurrencyEditingController(
      initialValue: 0.00,
      onValueChange: (newValue) {
        setState(() {});
      },
    );
  }

  void fundWallet() async {
    var price = int.parse(widget.homeControllers.walletAmount.text) * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref_${DateTime.now()}'
      ..email = 'rubies0004@gmail.com'
      ..currency = 'NGN';
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    final indexNumber = StateProvider<int>((ref) => 0);

    if (response.status = true) {
      message = 'Payment was successful. Ref: ${response.reference}';
      if (mounted) {}
      generalSuccessfullDialog(
        context: context,
        description:
            'Congratulations your account as been successful create continue to dashboard',
        onTap: () {
          PageNavigator(ctx: context).nextPageOnly(
              page: AggBottomNavBar(
            indexProvider: indexNumber,
          ));
        },
      );
    } else {
      print(response.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    ref.watch(walletAmountProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 138, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your payment getway',
              style:
                  AppStyleGilroy.kFontW7.copyWith(fontSize: 20, color: kBlack2),
            ),
            const SizedBox(height: 9),
            Text(
              'Complete your verification to use all the app features',
              style: AppStyleGilroy.kFontW6
                  .copyWith(fontSize: 12, color: kBlack2.withOpacity(0.8)),
            ),
            const SizedBox(height: 43),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 91,
                    width: 345,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _checked ? kRed : kBlack50)),
                    child: Center(
                      child: AbilityTextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          borderColor: Colors.transparent,
                          controller: widget.homeControllers.walletAmount,
                          validator: (value) =>
                              ValidationHelper().validateAmount(value!)
                          // onChanged: (value) {
                          //   ref.watch(isEditingProvider.notifier).state = true;
                          //   if (value.isEmpty) {
                          //     ref.watch(isEditingProvider.notifier).state =
                          //         false;
                          //   }
                          //   // setState(() {
                          //   //   _checked =
                          //   //       value.isNotEmpty;
                          //   //   state.didChange(_checked);
                          //   // });
                          // },
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 94),
            AbilityButton(
              onPressed: () {
                // fundWalletSuccessfullDialog(context);
                if (_formKey.currentState!.validate()) {
                  fundWallet();
                }
              },
              borderRadius: 10,
              borderColor: !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
              buttonColor: !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
              // child: !ref.watch(loadingAgentLogin)
              //     ? Text(
              //         'continue',
              //         style: AppStyleGilroy.kFontW6
              //             .copyWith(color: kWhite, fontSize: 18),
              //       )
              //     : const Center(
              //         child: CircularProgressIndicator(
              //           strokeWidth: 6,
              //           color: kWhite,
              //           backgroundColor: kRed,
              //         ),
              //       ),
            )
          ],
        ),
      )),
    );
  }
}
