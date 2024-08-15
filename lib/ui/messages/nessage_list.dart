import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/search_text_field.dart';
import 'package:sera/ui/messages/messages_screen.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class UserMessage {
  final String name;
  final String message;
  final String imageUrl;
  final int unreadMessages;

  UserMessage({
    required this.name,
    required this.message,
    required this.imageUrl,
    required this.unreadMessages,
  });
}

class UserMessagesScreen extends StatelessWidget {
  static const String route = "messages_list_screen";
  final List<UserMessage> messages = [
    UserMessage(
      name: 'Jacob Jones',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 3,
    ),
    UserMessage(
      name: 'Esther Howard',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 2,
    ),
    UserMessage(
      name: 'Jenny Wilson',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 0,
    ),
    UserMessage(
      name: 'Robert Fox',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 0,
    ),
    UserMessage(
      name: 'Leslie Alexander',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 0,
    ),
    UserMessage(
      name: 'Ronald Richards',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 1,
    ),
    UserMessage(
      name: 'Cameron Williamson',
      message: 'Cool! I have some feedback on the "How it...',
      imageUrl: 'assets/3x/image2.png', // Replace with actual URL
      unreadMessages: 0,
    ),
  ];

  final TextEditingController searchController = TextEditingController();

  UserMessagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.secondary,
            size: 20,
          ),
        ),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        isbottom: true,
        iscenterTitle: true,
        title: Text('Chats',
            style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.secondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: BaseConstant.poppinsSemibold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SearchTextField(
              onChanged: (String? value) {
                if (value == null) return;
              },
              textInputAction: TextInputAction.done,
              hint: AppStrings.SEARCH,
              suffixIcon: Icon(
                Icons.search,
                color: theme.colorScheme.secondary,
              ),
              textInputType: TextInputType.name,
              textEditingController: searchController,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MessageTile(messages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final UserMessage message;

  MessageTile(this.message);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: theme.colorScheme.onPrimary,
        elevation: 1,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, MessagesScreen.route);
          },
          contentPadding: const EdgeInsets.all(4.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage(message.imageUrl),
          ),
          title: Text(
            message.name,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(message.message,
              style: theme.textTheme.titleSmall!.copyWith(
                color: const Color(0xff888F7F),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
          trailing: message.unreadMessages > 0
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0XFFB30A0A),
                  child: Text(
                    message.unreadMessages.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
