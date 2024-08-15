import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class NotificationScreen extends StatelessWidget {
  static const String route = "_notification_screen";
  final List<NotificationItem> newNotifications = [
    NotificationItem(
      image: "assets/3x/new_product.png",
      color: Color(0xff7AB042),
      title: 'New products',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    NotificationItem(
      image: "assets/3x/status.png",
      color: Color(0xffF6A91B),
      title: 'Order status changes (Pending)',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    NotificationItem(
      image: "assets/3x/event.png",
      color: Color(0xffAD630F),
      title: 'Relevant events',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    NotificationItem(
        image: "assets/3x/message.png",
        title: 'New Message',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        color: Color(0xff004AAB)),
    NotificationItem(
        image: "assets/3x/promotions.png",
        title: 'Promotions',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        color: Color(0xffFCDD04)),
  ];

  final List<NotificationItem> earlierNotifications = [
    NotificationItem(
      image: "assets/3x/new_product.png",
      color: Color(0xff7AB042),
      title: 'New products',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    NotificationItem(
      image: "assets/3x/status.png",
      color: Color(0xffF6A91B),
      title: 'Order status changes',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    NotificationItem(
      image: "assets/3x/event.png",
      color: Color(0xffAD630F),
      title: 'Relevant events',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.NOTIFICATIONS.toUpperCase(),
          style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView.builder(
          itemCount: newNotifications.length +
              earlierNotifications.length +
              2, // +2 for section titles
          itemBuilder: (context, index) {
            if (index == 0) {
              return SectionTitle(title: 'New');
            } else if (index <= newNotifications.length) {
              return NotificationTile(item: newNotifications[index - 1]);
            } else if (index == newNotifications.length + 1) {
              return SectionTitle(title: 'Earlier');
            } else {
              return NotificationTile(
                  item: earlierNotifications[
                      index - newNotifications.length - 2]);
            }
          },
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    final theme  =context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style:theme.textTheme.titleLarge!.copyWith(
          fontSize: 16,
          fontFamily: BaseConstant.poppinsRegular,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class NotificationItem {
  final String image;
  final String title;
  final String description;
  final Color color;

  NotificationItem({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}

class NotificationTile extends StatelessWidget {
  final NotificationItem item;
  NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: item.color,
        child: Image.asset(item.image),
      ),
      title: Text(
        item.title,
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.secondary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        item.description,
        style: theme.textTheme.titleSmall!.copyWith(
          color: BaseConstant.notificationSubtitleColor,
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
