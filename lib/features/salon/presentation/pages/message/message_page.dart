import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/message/components/message_card_component.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'name': 'Blossom Steele',
      'message': 'Good morning, anything...',
      'time': '11.32 PM',
      'unreadCount': 2,
      'image': 'https://i.pravatar.cc/150?u=1', // Placeholder
    },
    {
      'name': 'Jennie Whang',
      'message': 'Good morning, anything...',
      'time': '11.32 PM',
      'unreadCount': 2,
      'image': 'https://i.pravatar.cc/150?u=2',
    },
    {
      'name': 'Nathalie',
      'message': 'I would like to book an...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=3',
    },
    {
      'name': 'Julia Martha',
      'message': 'I would like to book an appoin...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=4',
    },
    {
      'name': 'Gina Apple',
      'message': 'I would like to book an appoin...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              Strings.messagesText,
              fontSize: 24,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyOne),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                CupertinoIcons.search,
                color: AppColors.blackTwo,
              ),
            ),
          ],
        ),
        VerticalSpacing(10),
        // Message List
        Expanded(
          child: ListView.separated(
            itemCount: _messages.length,
            separatorBuilder: (context, index) => VerticalSpacing(24),
            itemBuilder: (context, index) {
              final message = _messages[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RouteNames.messageDetail
                  );
                },
                child: MessageCardComponent(
                  name: message['name'],
                  message: message['message'],
                  time: message['time'],
                  unreadCount: message['unreadCount'],
                  imageUrl: message['image'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
