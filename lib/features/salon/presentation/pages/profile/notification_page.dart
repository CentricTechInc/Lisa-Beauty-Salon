import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/notification_item_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(
                        color: AppColors.greyOne,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                  ),
                ),
                const HorizontalSpacing(10),
                CommonText(
                  Strings.notificationsText,
                  fontSize: 24,
                  fontWeight: 600,
                  color: AppColors.blackOne,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 3,
              itemBuilder: (context, index) {
                final List<Map<String, String>> notifications = [
                  {
                    "title": "You have an appointment at The Galleria Hair Salon at 8:00am today",
                    "time": "Just now",
                    "isRead": "false",
                  },
                  {
                    "title": "Your password is successfully changed",
                    "time": "2 hours ago",
                    "isRead": "true",
                  },
                  {
                    "title": "Completed your profile to be better health consults. Complete Profile",
                    "time": "3 days ago",
                    "isRead": "true",
                  },
                ];

                final notification = notifications[index];
                return NotificationItemComponent(
                  title: notification['title']!,
                  time: notification['time']!,
                  isRead: notification['isRead'] == 'true',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
