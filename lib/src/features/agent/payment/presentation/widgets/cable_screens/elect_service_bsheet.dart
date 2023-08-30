import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void electServiceBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Consumer(
          builder: (context, ref, child) {
            final electListVal = ref.watch(getElectricityListProvider);
            return Column(
              children: [
                Text(
                  'Select Service Provider',
                  style: AppStyleRoboto.kFontW6.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: electListVal.when(
                    data: (data) {
                      final names = data.data.data;

                      return ListView.builder(
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            final isSelected = index ==
                                ref.watch(selectedRowProvider.notifier).state;
                            return InkWell(
                              onTap: () {
                                ref.read(selectedRowProvider.notifier).state =
                                    index;

                                ref.read(selectedElectProvider.notifier).state =
                                    names[index].name.toString();

                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        child: Text(
                                      names[index].name,
                                      style: AppStyleRoboto.kFontW6.copyWith(
                                          fontSize: 14, color: kGrey1),
                                    )),
                                    Icon(
                                      Icons.radio_button_on_outlined,
                                      color: isSelected ? kPrimary : kGrey,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    error: (e, s) => Text(e.toString()),
                    loading: () => const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: kPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
