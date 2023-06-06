import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AbilityPasswordField extends ConsumerWidget {
  const AbilityPasswordField({
    Key? key,
    required this.hintText,
    this.width,
    this.prefixIcon,
    required this.heading,
    this.validator,
    this.onChanged,
    this.controller,
    this.iconName,
    this.hidePasswrodOntap,
    this.borderRadius,
    this.maxLength,
    this.keyboardType,
  }) : super(key: key);

  final String? hintText;
  final String? heading;
  final double? width;
  final Widget? prefixIcon;
  final IconData? iconName;
  final Function()? hidePasswrodOntap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final BorderRadius? borderRadius;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hidePasword = ref.watch(hidePasswordProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading ?? '',
            style: AppStyleGilroy.kFontW6.copyWith(fontSize: 16, color: kBlack),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: hidePasword,
            validator: validator,
            controller: controller,
            maxLength: maxLength,
            keyboardType: keyboardType,
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
              if (value.length >= maxLength!) {
                FocusScope.of(context).unfocus();
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              prefixIcon: Icon(
                iconName,
                color: kBlack,
                size: 20,
              ),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimary)),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                borderSide: BorderSide(color: kPrimary.withOpacity(0.3)),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  ref.read(hidePasswordProvider.notifier).state =
                      !ref.read(hidePasswordProvider.notifier).state;
                },
                child: hidePasword
                    ? const Icon(
                        Icons.visibility,
                        color: kBlack,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: kBlack,
                        size: 20,
                      ),
              ),
              hintStyle:
                  AppStyleGilroy.kFontW5.copyWith(fontSize: 14, color: kGrey),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                borderSide: const BorderSide(color: kRed),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                borderSide: const BorderSide(color: kRed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AbilityPasswordField2 extends ConsumerWidget {
  const AbilityPasswordField2({
    Key? key,
    required this.hintText,
    this.width,
    this.prefixIcon,
    required this.heading,
    this.validator,
    this.onChanged,
    this.controller,
    this.iconName,
    this.hidePasswrodOntap,
    this.borderRadius,
    this.maxLength,
    this.keyboardType,
  }) : super(key: key);

  final String? hintText;
  final String? heading;
  final double? width;
  final Widget? prefixIcon;
  final IconData? iconName;
  final Function()? hidePasswrodOntap;
  final BorderRadius? borderRadius;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hidePasword2 = ref.watch(hidePasswordProvider2);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading ?? '',
            style: AppStyleGilroy.kFontW6.copyWith(fontSize: 16, color: kBlack),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: hidePasword2,
            validator: validator,
            controller: controller,
            maxLength: maxLength,
            keyboardType: keyboardType,
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
              if (value.length >= maxLength!) {
                FocusScope.of(context).unfocus();
                ref.watch(isEditingProvider.notifier).state = false;
              }
            },
            onFieldSubmitted: (value) {
              ref.watch(isEditingProvider.notifier).state = false;
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              ref.watch(isEditingProvider.notifier).state = false;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              prefixIcon: Icon(
                iconName,
                color: kBlack,
                size: 20,
              ),
              counterText: '',
              hintText: hintText,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: kPrimary)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: kPrimary.withOpacity(0.3)),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  ref.read(hidePasswordProvider2.notifier).state =
                      !ref.read(hidePasswordProvider2.notifier).state;
                },
                child: hidePasword2
                    ? const Icon(
                        Icons.visibility,
                        color: kBlack,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: kBlack,
                        size: 20,
                      ),
              ),
              hintStyle:
                  AppStyleGilroy.kFontW5.copyWith(fontSize: 14, color: kGrey),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: kRed),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: kRed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
