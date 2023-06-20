// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AggregatorPasscodeLogin extends ConsumerWidget {
  ValidationHelper validationHelper;
  AggregatorController aggregatorController;
  AggregatorPasscodeLogin(this.validationHelper, this.aggregatorController,
      {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const BackIcon(),
                  const SizedBox(height: 39),
                  Text('Passcode',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 10),
                  Text('Agg Please login with your passcode',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 35),
                  Center(
                    child: GeneralPinCode(
                        pinLenght: 4,
                        boxPinShape: PinCodeFieldShape.box,
                        controller: aggregatorController.signupPasscode,
                        validator: (value) =>
                            validationHelper.validatePinCode2(value!)),
                  ),
                  const SizedBox(height: 153.54),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAggregatorPasscode.notifier)
                            .getPasscodeService(
                                context: context,
                                passcode:
                                    aggregatorController.signupPasscode.text);
                      }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAggregatorPasscode)
                        ? Text(
                            'continue',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 18),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: kWhite,
                            ),
                          ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          ref.watch(isAgentServiceProvider)
                              ? PageNavigator(ctx: context).nextPage(
                                  page: AgentLoginScreen(
                                      ValidationHelper(), AgentController()))
                              : PageNavigator(ctx: context).nextPage(
                                  page: AgentLoginScreen(
                                      ValidationHelper(), AgentController()));
                        },
                        child: Text(
                          "Login ",
                          style: AppStyleRoboto.kFontW5
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      ),
                      Text(
                        "with your password",
                        style: AppStyleRoboto.kFontW4
                            .copyWith(fontSize: 16, color: kGrey2),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
