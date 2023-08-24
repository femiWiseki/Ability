import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AbilityPhoneNumber extends StatefulWidget {
  const AbilityPhoneNumber({
    super.key,
    required TextEditingController phoneController,
    required this.prefixWidget,
    this.validator,
    this.maxLength,
    this.autoFillHints,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;
  final Widget prefixWidget;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Iterable<String>? autoFillHints;

  @override
  State<AbilityPhoneNumber> createState() => _AbilityPhoneNumberState();
}

class _AbilityPhoneNumberState extends State<AbilityPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone number',
          style: AppStyleGilroy.kFontW4.copyWith(fontSize: 14, color: kBlack),
        ),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, child) {
            return TextFormField(
              controller: widget._phoneController,
              keyboardType: TextInputType.phone,
              validator: widget.validator,
              maxLength: widget.maxLength,
              autofillHints: widget.autoFillHints,
              // autovalidateMode: AutovalidateMode.onUserInteraction,

              textInputAction:
                  TextInputAction.done, // set the text input action to done
              onTap: () {
                ref.watch(isEditingProvider.notifier).state = true;
              },
              onChanged: (value) {
                ref.watch(isEditingProvider.notifier).state = false;
                if (value.isEmpty) {
                  ref.watch(isEditingProvider.notifier).state = true;
                }
                if (value.length >= widget.maxLength!) {
                  FocusScope.of(context).unfocus();
                  ref.watch(isEditingProvider.notifier).state = false;
                }
              },
              onFieldSubmitted: (value) {
                ref.watch(isEditingProvider.notifier).state = false;
              },
              onTapOutside: (event) {
                // FocusScope.of(context).unfocus();
                // ref.watch(isEditingProvider.notifier).state = false;
              },
              decoration: InputDecoration(
                prefixIcon: widget.prefixWidget,
                counterText: '',
                hintText: '8142415154',
                contentPadding: const EdgeInsets.all(0),
                hintStyle: AppStyleGilroy.kFontW4
                    .copyWith(fontSize: 12, color: kGrey11),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kPrimary)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: kPrimary.withOpacity(0.3)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kRed),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kRed),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
