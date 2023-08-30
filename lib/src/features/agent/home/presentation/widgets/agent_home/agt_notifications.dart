// ignore_for_file: unused_result

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/home/application/services/agt_del_all_noti_service.dart';
import 'package:ability/src/features/agent/home/application/services/agt_del_id_noti_service.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/agt_notifications_tile.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/delete_noti_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtNotifications extends ConsumerStatefulWidget {
  const AgtNotifications({super.key});

  @override
  ConsumerState<AgtNotifications> createState() => _AgtNotificationsState();
}

class _AgtNotificationsState extends ConsumerState<AgtNotifications> {
  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(getAgtNotificationsProvider);
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(
            children: [
              const AppHeader(
                heading: 'Notifications',
              ),
              const SizedBox(height: 30),
              AbilityButton(
                onPressed: () {
                  deleteNotificationDialog(
                      context: context,
                      deleteNoti: () {
                        AgtDelAllNotificationsService()
                            .agtNotifications(context: context);
                        ref.refresh(getAgtNotificationsProvider);
                      });
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                },
                height: 40,
                buttonColor: kRed,
                borderColor: kRed,
                title: 'Delete All Notifications',
              ),
              const SizedBox(height: 20),
              notifications.when(
                data: (data) {
                  final notList = data.data.notification;
                  return Expanded(
                    child: notList.isNotEmpty
                        ? ListView.builder(
                            itemCount: notList.length,
                            itemBuilder: (context, index) {
                              final notID = notList[index].id;
                              DateTime notTime = notList[index].createdAt;
                              String formattedDate =
                                  DateFormat('MMM dd, yyyy, hh:mm a')
                                      .format(notTime);
                              Future.delayed(Duration.zero, () {
                                ref
                                    .read(notificationIdProvider.notifier)
                                    .state = notID;
                              });

                              return Dismissible(
                                key: ValueKey('${notList[index].id}_$index'),
                                background: Container(
                                  color: kRed,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.delete_forever,
                                          color: kWhite, size: 50),
                                      Icon(Icons.delete_forever,
                                          color: kWhite, size: 50),
                                    ],
                                  ),
                                ),
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) {
                                  AgtDelIdNotificationService()
                                      .agtNotifications(
                                    context: context,
                                    notiId: ref.watch(notificationIdProvider),
                                  );
                                  // ref.refresh(getAgtNotificationsProvider);
                                },
                                child: AgtNotificationsTile(
                                  title: notList[index].title,
                                  dateTime: formattedDate,
                                  body: notList[index].body,
                                ),
                              );
                            },
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('Notification list is empty')],
                          ),
                  );
                },
                error: (e, s) => Text(e.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: kPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
