import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/util/base_constants.dart';

class MessagesScreen extends StatelessWidget {
  static const String route = "_chat_detail_screen";
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;

    return Scaffold(
        backgroundColor: const Color(0xfff8f8f7),
      //  backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/3x/image2.png'), // Replace with your image asset
              ),
              const SizedBox(width: 10),
              Text(
                'Jacob Jones',
                style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.secondary,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                color: theme.colorScheme.secondary,
                                height: 0.5,
                                width: size.width * .36),
                            DateLabel(date: '   Oct 10 2023   '),
                            Container(
                              color: theme.colorScheme.secondary,
                              height: 0.5,
                              width: size.width * .36,
                            ),
                          ],
                        ),
                        const OtherChat(
                          message: 'All good! We have some questions..',
                          time: '12:33 PM',
                          avatar: 'assets/3x/image2.png',
                        ),
                        const OtherChat(
                          message:
                              'Cool! I have some feedback on the "How it Work" section. But overall looks good now!',
                          time: '12:33 PM',
                          avatar: 'assets/3x/image2.png',
                        ),
                        const MyChat(
                          message: 'Hi Sarah Akilapa! How about this project?',
                          time: '3:23 PM',
                          avatar: 'assets/3x/image2.png',
                        ),
                        const OtherChat(
                          message:
                              'Hi David Liberia! I will report you as soon as possible 😄',
                          time: '12:55 PM',
                          avatar: 'assets/3x/image2.png',
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                color: theme.colorScheme.secondary,
                                height: 0.5,
                                width: size.width * .36),
                            DateLabel(date: '  Oct 10 2023  '),
                            Container(
                              color: theme.colorScheme.secondary,
                              height: 0.5,
                              width: size.width * .36,
                            ),
                          ],
                        ),
                        const OtherChatWithImage(
                          message: 'Sarah Akilapa',
                          time: '12:55 PM',
                          image: 'assets/3x/chat_image.png',
                          avatar: 'assets/3x/image2.png',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ChatInputField(),
            ],
          ),
        ));
  }
}

class DateLabel extends StatelessWidget {
  final String date;

  const DateLabel({required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          date,
          style: const TextStyle(
              color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class MyChat extends StatelessWidget {
  final String message;
  final String time;
  final String avatar;
  const MyChat(
      {required this.message, required this.avatar, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final size = context.mediaSize;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: size.width * .7,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              time,
              style: theme.textTheme.titleSmall!.copyWith(
                  color: BaseConstant.notificationSubtitleColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Material(
          elevation: 2,
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset("assets/3x/emoji.png"),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontFamily: BaseConstant.poppinsRegular,
                        fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Type here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Image.asset("assets/3x/image_select.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherChatWithImage extends StatelessWidget {
  final String message;
  final String time;
  final String image;
  final String avatar;

  const OtherChatWithImage(
      {required this.message,
      required this.time,
      required this.image,
      required this.avatar});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jacob Jones',
              style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image),
                ],
              ),
            ),
            Text(
              time,
              style: theme.textTheme.titleSmall!.copyWith(
                  color: BaseConstant.notificationSubtitleColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

class OtherChat extends StatelessWidget {
  final String message;
  final String time;
  final String avatar;
  const OtherChat(
      {required this.message, required this.time, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jacob Jones',
              style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              width: size.width * .7,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Text(
                message,
                style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              time,
              style: theme.textTheme.titleSmall!.copyWith(
                  color: BaseConstant.notificationSubtitleColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
