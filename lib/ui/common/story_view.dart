import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/extensions/context_extension.dart';

class StoryView extends StatelessWidget {
  static const String route = '/story_view_screen';
  StoryModel story;
  StoryView({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final size = context.mediaSize;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                context.isDarkTheme ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                context.isDarkTheme ? Brightness.dark : Brightness.light),
        child: Scaffold(
            body: Stack(children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.network("$pictureUrl${story.fileUrl}",
                  fit: BoxFit.cover)),
          Positioned(
              top: kToolbarHeight + 5,
              left: 30,
              child: Row(children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios,
                        color: theme.colorScheme.onPrimary, size: 20)),
                const SizedBox(width: 6),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: theme.colorScheme.onPrimary, width: 2.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              
                                        "$pictureUrl${story.appUser!.profileImage}",
                              
                              
                              
                              ), fit: BoxFit.cover))),
                const SizedBox(width: 6),
                Text(
                  
                                        "${story.appUser!.firstName} ${story.appUser!.lastName}"
                  ,
                    style: textTheme.titleMedium!.copyWith(
                        fontSize: 14, color: theme.colorScheme.surface))
              ]))
        ])));
  }
}
