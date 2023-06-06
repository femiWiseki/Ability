import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AbilityTextField extends StatelessWidget {
  const AbilityTextField({
    Key? key,
    this.hintText,
    this.heading,
    this.keyboardType,
    required this.controller,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.iconName,
    this.maxLength,
  }) : super(key: key);
  final String? hintText;
  final String? heading;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final IconData? iconName;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines, minLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading ?? '',
          style: AppStyleGilroy.kFontW6.copyWith(fontSize: 16, color: kBlack),
        ),
        const SizedBox(height: 5),
        Consumer(
          builder: (context, ref, child) {
            return TextFormField(
              controller: controller,
              validator: validator,
              minLines: maxLines,
              maxLines: maxLines,
              maxLength: maxLength,

              textInputAction:
                  TextInputAction.done, // set the text input action to done
              onTap: () {
                ref.watch(isEditingProvider.notifier).state = true;
              },
              onChanged: (value) {
                ref.watch(isEditingProvider.notifier).state = true;
                if (value.isEmpty) {
                  ref.watch(isEditingProvider.notifier).state = false;
                }
              },
              onFieldSubmitted: (value) {
                ref.watch(isEditingProvider.notifier).state = false;
              },
              onTapOutside: (event) {
                // FocusScope.of(context).unfocus();
                ref.watch(isEditingProvider.notifier).state = false;
              },
              keyboardType: keyboardType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                filled: true,
                fillColor: kTransparent,
                hintText: hintText,
                counterText: '',
                prefixIcon: iconName == null
                    ? null
                    : Icon(
                        iconName,
                        color: kBlack,
                        size: 20,
                      ),
                suffixIcon: suffixIcon,
                hintStyle:
                    AppStyleGilroy.kFontW5.copyWith(fontSize: 14, color: kGrey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: kPrimary.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: kPrimary.withOpacity(0.2))),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: kRed)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: kRed)),
              ),
            );
          },
        ),
      ],
    );
  }
}
