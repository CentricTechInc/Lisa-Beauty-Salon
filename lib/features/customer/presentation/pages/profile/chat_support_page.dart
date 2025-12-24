import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class CustomerChatSupportPage extends StatefulWidget {
  const CustomerChatSupportPage({super.key});

  @override
  State<CustomerChatSupportPage> createState() => _CustomerChatSupportPageState();
}

class _CustomerChatSupportPageState extends State<CustomerChatSupportPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final ValueNotifier<bool> _showEmojiPicker = ValueNotifier<bool>(false);

  final List<Map<String, dynamic>> _messages = [
    {
      'isMe': false,
      'type': 'typing',
      'avatar': 'https://i.pravatar.cc/150?u=8',
    },
    {
      'isMe': false,
      'type': 'text',
      'message':
          'Good morning, anything we can help at Plush Beauty Longue Salon?',
      'time': '11:20 PM',
      'isRead': false,
      'avatar': 'https://i.pravatar.cc/150?u=8',
    },
    {
      'isMe': true,
      'type': 'text',
      'message': 'Hello, good morning :)',
      'time': '11:20 PM',
      'isRead': true,
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
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      onWhiteSpaceTap: () {
        _showEmojiPicker.value = false;
      },
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
                const CommonText(
                  Strings.chatSupportText,
                  fontSize: 24,
                  fontWeight: 600,
                  color: AppColors.blackOne,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
          _buildMessageInput(),
          _buildEmojiPicker(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isMe = msg['isMe'];

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
              Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.greyOne.withValues(
                    alpha: 0.3
                  ) : const Color(0xFF1F1F1F),
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
              if (msg['time'] != null && msg['time'].isNotEmpty) ...[
                const VerticalSpacing(4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      msg['time'],
                      fontSize: 10,
                      fontWeight: 400,
                      color: AppColors.greyTwo,
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
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      color: AppColors.whiteTwo,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.whiteOne,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.greyOne),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: _messageController,
                        focusNode: _messageFocusNode,
                        hintText: Strings.typeMessageHint,
                        hintColor: AppColors.greyTwo,
                        borderColor: AppColors.transparent,
                        fillColor: AppColors.transparent,
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
            GestureDetector(
              onTap: () {
                // Send message action
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return ValueListenableBuilder<bool>(
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
              config: Config(
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
