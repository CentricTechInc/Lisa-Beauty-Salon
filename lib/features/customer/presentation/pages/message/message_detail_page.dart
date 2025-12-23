import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({super.key});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final ValueNotifier<bool> _showEmojiPicker = ValueNotifier<bool>(false);

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
      'avatar': 'https://i.pravatar.cc/150?u=12',
    },
    {
      'isMe': true,
      'type': 'text',
      'message': 'This look awesome 😍',
      'time': '11:20 PM',
      'isRead': false,
    },
    {
      'isMe': true,
      'type': 'image',
      'image': 'https://picsum.photos/300/300',
      'time': '11:20 PM',
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
      'avatar': 'https://i.pravatar.cc/150?u=12',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    _showEmojiPicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      bgColor: AppColors.whiteTwo,
      onWhiteSpaceTap: () {
        _showEmojiPicker.value = false;
        _messageFocusNode.unfocus();
      },
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOne,
                    border: Border.all(color: AppColors.greyOne, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                ),
              ),
              const HorizontalSpacing(16),
              const Column(
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
          const VerticalSpacing(08),

          // Chat List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 05),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                          child: CommonTextField(
                            controller: _messageController,
                            focusNode: _messageFocusNode,
                            hintText: Strings.typeMessageHint,
                            hintColor: AppColors.greyTwo,
                            borderColor: AppColors.greyFour,
                            fillColor: AppColors.greyFour,
                            textColor: AppColors.blackTwo,
                            cursorColor: AppColors.blackTwo,
                            contentPadding: EdgeInsets.zero,
                            textOnTap: () {
                              if (_showEmojiPicker.value) {
                                _showEmojiPicker.value = false;
                              }
                            },
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _showEmojiPicker,
                          builder: (context, showEmoji, child) {
                            return GestureDetector(
                              onTap: () {
                                _showEmojiPicker.value = !_showEmojiPicker.value;
                                if (_showEmojiPicker.value) {
                                  _messageFocusNode.unfocus();
                                } else {
                                  _messageFocusNode.requestFocus();
                                }
                              },
                              child: Icon(
                                showEmoji ? Icons.keyboard : Icons.mood,
                                color: AppColors.greyTwo,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const HorizontalSpacing(12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.pinkOne,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      Assets.sendIcon,
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Emoji Picker
          ValueListenableBuilder<bool>(
            valueListenable: _showEmojiPicker,
            builder: (context, showEmoji, child) {
              return Offstage(
                offstage: !showEmoji,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      _messageController.text += emoji.emoji;
                    },
                    textEditingController: _messageController,
                    config: const Config(
                      height: 256,
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax: 28,
                        backgroundColor: AppColors.whiteOne,
                        columns: 7,
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                      categoryViewConfig: CategoryViewConfig(
                        backgroundColor: AppColors.whiteOne,
                        iconColor: AppColors.greyTwo,
                        iconColorSelected: AppColors.pinkOne,
                        indicatorColor: AppColors.pinkOne,
                      ),
                      bottomActionBarConfig: BottomActionBarConfig(
                        backgroundColor: AppColors.whiteOne,
                        buttonColor: AppColors.whiteOne,
                        buttonIconColor: AppColors.greyTwo,
                      ),
                      searchViewConfig: SearchViewConfig(
                        backgroundColor: AppColors.whiteOne,
                        buttonIconColor: AppColors.greyTwo,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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
              height: 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(msg['avatar']),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const HorizontalSpacing(12),
          ],
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (isImage) ...[
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.greyFour,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(msg['image'], fit: BoxFit.cover),
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.greyFour
                      : AppColors.blackThree,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: isMe ? Radius.zero : const Radius.circular(16),
                      bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                      bottomRight: const Radius.circular(16),
                    ),
                  ),
                  child: CommonText(
                    msg['message'],
                    color: isMe ? AppColors.blackTwo : AppColors.whiteOne,
                    fontSize: 14,
                    fontWeight: 400,
                    lineHeight: 1.4,
                    textOverflow: TextOverflow.visible,
                  ),
                ),
              ],
              if (msg['time'] != null && msg['time'].isNotEmpty) ...[
                const VerticalSpacing(4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg['time'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.greyTwo,
                        fontFamily: Strings.fontFamily,
                      ),
                    ),
                    if (isMe && msg['isRead']) ...[
                      const HorizontalSpacing(4),
                      const Icon(
                        Icons.done_all,
                        size: 14,
                        color: AppColors.pinkOne,
                      ),
                    ],
                  ],
                ),
              ],
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
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const HorizontalSpacing(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Dot(),
                SizedBox(width: 4),
                _Dot(opacity: 0.6),
                SizedBox(width: 4),
                _Dot(opacity: 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double opacity;
  const _Dot({this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.pinkOne.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
