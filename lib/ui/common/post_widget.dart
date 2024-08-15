import 'package:flutter/material.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/extensions/context_extension.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      color: theme.colorScheme.onPrimary,
      // shadowColor: theme.colorScheme.onSecondary,
      // elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading:  CircleAvatar(
                backgroundImage: NetworkImage("$pictureUrl${post.appUser!.profileImage}"),
              ),
              title: Text(
                "${post.appUser!.firstName!} ${post.appUser!.lastName!}",
                style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 12,
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ), 
              subtitle: Text(
                post.createdDate.toString(),
                style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    color:
                        theme.colorScheme.secondaryContainer.withOpacity(0.4),
                    fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
          post.caption!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    post.caption!,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.secondaryContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    "",
                    style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
        post.imageUrl!=null&&  post.imageUrl!.isNotEmpty?
            Center(child: Image.network("$pictureUrl${post.imageUrl!}")):
            const SizedBox(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                post.product!.category != null?
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(25),
                  color: theme.colorScheme.onTertiary,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 0.5,
                            color: theme.colorScheme.secondaryContainer),
                        color: theme.colorScheme.onTertiary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: post.product!.category != null
                          ? Text(
                              post.product!.category!,
                              style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )
                          : Text(
                              "",
                              style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                    ),
                  ),
                ):
                const SizedBox(),
                const Spacer(),
                GestureDetector(
                  child: Image.asset("assets/3x/share.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                post.isLike==true?
                GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    color: theme.colorScheme.error,
                  ),
                  onTap: () {},
                )
                
                :
               GestureDetector(
                  child: Icon(
                    Icons.favorite_outline,
                    color: theme.colorScheme.error,
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String username;
  final String time;
  final String content;
  final String imageUrl;
  final String buttonText;

  Post({
    required this.username,
    required this.time,
    required this.content,
    required this.imageUrl,
    required this.buttonText,
  });
}
