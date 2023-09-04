import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void cableServiceBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return const CableServiceBottomSheetContent();
    },
  );
}

class CableServiceBottomSheetContent extends ConsumerWidget {
  const CableServiceBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cableListVal = ref.watch(getCableListProvider);
    final isSearching = ref.watch(isSearchingProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: [
          Text(
            'Select Service Package',
            style: AppStyleRoboto.kFontW6.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (newSearchQuery) {
              ref.read(searchQueryProvider.notifier).state = newSearchQuery;
            },
            decoration: InputDecoration(
              hintText: 'Search package...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  ref.read(isSearchingProvider.notifier).state = false;
                  ref.read(searchQueryProvider.notifier).state = '';
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: cableListVal.when(
              data: (data) {
                final names = data.data.data;
                final filteredNames = names
                    .where((name) => name.name
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: filteredNames.length,
                  itemBuilder: (context, index) {
                    final isSelected =
                        index == ref.read(selectedRowProvider.notifier).state;

                    return InkWell(
                      onTap: () {
                        ref.read(selectedRowProvider.notifier).state = index;
                        ref.read(selectedCableProvider.notifier).state =
                            filteredNames[index].name.toString();

                        ref.read(selectedCableAmount.notifier).state =
                            filteredNames[index].amount;

                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "${filteredNames[index].name} - ₦${filteredNames[index].amount}",
                                style: AppStyleRoboto.kFontW6
                                    .copyWith(fontSize: 14, color: kGrey1),
                              ),
                            ),
                            // Icon(
                            //   Icons.radio_button_on_outlined,
                            //   color: isSelected ? kPrimary : kGrey,
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                );
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
      ),
    );
  }
}
