import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({super.key});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isMe': true,
      'type': 'text',
      'message': 'Hello, good morning :)',
      'time': '11:20 PM',
      'isRead': true,
    },
    {
      'isMe': false,
      'type': 'text',
      'message': 'Good morning, anything we can help at Plush Beauty Longue Salon?',
      'time': '11:20 PM',
      'isRead': false,
       'avatar': 'https://i.pravatar.cc/150?u=8',
    },
    {
      'isMe': true,
      'type': 'text',
      'message': 'This look awesome 😍',
      'time': '', // Time not shown in screenshot for this one explicitly usually
      'isRead': false, // No check shown in screenshot immediately
    },
    {
      'isMe': true,
      'type': 'image',
      'image': 'https://picsum.photos/300/300', // Placeholder
      'time': '',
       'isRead': false,
    },
     {
      'isMe': true,
      'type': 'text',
      'message': 'I would like to book an appointment at 2:30 PM today.',
      'time': '11:20 PM',
      'isRead': true,
    },
      {
      'isMe': false,
      'type': 'typing',
       'avatar': 'https://i.pravatar.cc/150?u=8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOne,
      body: SafeArea(
        child: Column(
          children: [
             VerticalSpacing(16),
             // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(
                        color: AppColors.greyOne,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        16
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppColors.blackTwo,
                    ),
                  ),
                  HorizontalSpacing(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        'Bloom & Blade',
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      CommonText(
                        Strings.onlineText,
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.greenOne,
                      ),
                    ],
                  ),
                ],
              ),
            ),
             VerticalSpacing(16),
            
            // Chat List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                   if (msg['type'] == 'typing') {
                    return _buildTypingIndicator(msg['avatar']);
                  }
                  return _buildMessageBubble(msg);
                },
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.greyFour,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: Strings.typeMessageHint,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: const TextStyle(
                                fontSize: 14, 
                                color: AppColors.blackTwo,
                                fontFamily: Strings.fontFamily
                              ),
                            ),
                          ),
                          const Icon(Icons.mood, color: AppColors.greyTwo),
                        ],
                      ),
                    ),
                  ),
                  HorizontalSpacing(12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.pinkOne,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.send, color: AppColors.whiteOne),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isMe = msg['isMe'];
    final isImage = msg['type'] == 'image';

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Container(
              width: 32,
            ),
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(msg['avatar']),
            ),
            HorizontalSpacing(12),
          ],
           Column(
             crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
             children: [
               if (isImage)
                 Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(msg['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                 )
                else
                 Container(
                   padding: const EdgeInsets.all(16),
                   constraints: BoxConstraints(
                     maxWidth: MediaQuery.of(context).size.width * 0.7,
                   ),
                   decoration: BoxDecoration(
                     color: isMe ? AppColors.greyOne.withOpacity(0.3) : const Color(0xFF1F1F1F), // Dark for received
                     borderRadius: BorderRadius.only(
                       topLeft: const Radius.circular(16),
                       topRight: const Radius.circular(16),
                       bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                       bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                     ),
                   ),
                   child: CommonText(
                     msg['message'],
                     color: isMe ? AppColors.blackTwo : AppColors.whiteOne,
                     fontSize: 14,
                     fontWeight: 400,
                     lineHeight: 1.4,
                   ),
                 ),
                 
                 if (msg['time'] != null && msg['time'].isNotEmpty) ...[
                    VerticalSpacing(4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          msg['time'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.greyTwo,
                            fontFamily: Strings.fontFamily
                          ),
                        ),
                        if (isMe && msg['isRead']) ...[
                           HorizontalSpacing(4),
                           const Icon(Icons.done_all, size: 14, color: AppColors.pinkOne),
                        ]
                      ],
                    ),
                 ]
             ],
           ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(String avatarUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
           CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            HorizontalSpacing(12),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                   decoration: BoxDecoration(
                     color:  const Color(0xFF1F1F1F),
                     borderRadius: BorderRadius.only(
                       topLeft: const Radius.circular(16),
                       topRight: const Radius.circular(16),
                        bottomLeft: Radius.zero,
                       bottomRight: const Radius.circular(16),
                     ),
                   ),
                   child: const Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                        _Dot(),
                        SizedBox(width: 4),
                        _Dot(),
                         SizedBox(width: 4),
                        _Dot(),
                     ],
                   ),
            ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: AppColors.pinkOne,
        shape: BoxShape.circle,
      ),
    );
  }
}