import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
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
    this.borderRadius,
    this.textAlign,
    this.borderColor,
    this.readOnly,
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
  final BorderRadius? borderRadius;
  final TextAlign? textAlign;
  final Color? borderColor;
  final bool? readOnly;

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
              readOnly: readOnly ?? false,
              textAlign: textAlign ?? TextAlign.start,
              textInputAction:
                  TextInputAction.done, // set the text input action to done
              onTap: () {
                ref.watch(isEditingProvider.notifier).state = true;
              },
              onChanged: onChanged ??
                  (value) {
                    ref.watch(isEditingProvider.notifier).state = false;
                    if (value.isEmpty) {
                      ref.watch(isEditingProvider.notifier).state = true;
                    }
                  },
              onFieldSubmitted: (value) {
                ref.watch(isEditingProvider.notifier).state = false;
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
                // ref.watch(isEditingProvider.notifier).state = false;
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
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: borderColor ?? kPrimary.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: borderColor ?? kPrimary.withOpacity(0.2))),
                errorBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: const BorderSide(color: kRed)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: const BorderSide(color: kRed)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
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
    this.borderRadius,
    this.textAlign,
    this.borderColor,
    this.readOnly,
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
  final BorderRadius? borderRadius;
  final TextAlign? textAlign;
  final Color? borderColor;
  final bool? readOnly;

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
              readOnly: readOnly ?? false,
              textAlign: textAlign ?? TextAlign.start,
              textInputAction:
                  TextInputAction.done, // set the text input action to done
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
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: borderColor ?? kPrimary.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: borderColor ?? kPrimary.withOpacity(0.2))),
                errorBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: const BorderSide(color: kRed)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    borderSide: const BorderSide(color: kRed)),
              ),
            );
          },
        ),
      ],
    );
  }
}
