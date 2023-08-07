import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void dataServiceBottomSheet({required BuildContext context}) {
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
            final dataValue = ref.watch(getDataProvider);
            return Column(
              children: [
                Text(
                  'Select Data Plan',
                  style: AppStyleRoboto.kFontW6.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: dataValue.when(
                    data: (data) {
                      List<String> names =
                          data.data.values.map((datum) => datum.name).toList();
                      List<int> amounts = data.data.values
                          .map((datum) => datum.amount)
                          .toList();

                      return ListView.builder(
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            final isSelected = index ==
                                ref.watch(selectedRowProvider.notifier).state;
                            return InkWell(
                              onTap: () {
                                ref.read(selectedRowProvider.notifier).state =
                                    index;

                                ref.read(selectedDataAmount.notifier).state =
                                    '${amounts[index]}';

                                ref.read(selectedDataPlanName.notifier).state =
                                    names[index].toString();

                                ref.read(selectedDataPlan.notifier).state =
                                    "${names[index]} - ₦${amounts[index]}";
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
                                      "${names[index]} - ₦${amounts[index]}",
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
