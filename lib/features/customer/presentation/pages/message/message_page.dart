import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_message_card.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'name': 'Bloom & Blade',
      'message': 'Good morning, anything...',
      'time': '11.32 PM',
      'unreadCount': 2,
      'image': 'https://i.pravatar.cc/150?u=12', 
    },
    {
      'name': 'Lovely Lather',
      'message': 'Good morning, anything...',
      'time': '11.32 PM',
      'unreadCount': 2,
      'image': 'https://i.pravatar.cc/150?u=13',
    },
    {
      'name': 'Cute Stuff Salon',
      'message': 'I would like to book an...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=14',
    },
    {
      'name': 'Love Live Salon',
      'message': 'I would like to book an appoin...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=15',
    },
    {
      'name': 'Glitter Pop Salon',
      'message': 'I would like to book an appoin...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'image': 'https://i.pravatar.cc/150?u=16',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20
      ),
      child: Column(
        children: [
          const VerticalSpacing(20),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                Strings.messagesText,
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
              GestureDetector(
                onTap: () {
                  showFeatureUnderDevelopment();
                },
                child: Container(
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
              ),
            ],
          ),
          const VerticalSpacing(24),
          // Message List
          Expanded(
            child: ListView.separated(
              itemCount: _messages.length,
              separatorBuilder: (context, index) => const VerticalSpacing(24),
              itemBuilder: (context, index) {
                final message = _messages[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteNames.messageDetail);
                  },
                  child: CommonMessageCard(
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
      ),
    );
  }
}
