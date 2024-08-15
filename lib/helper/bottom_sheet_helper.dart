import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_screen.dart';
import 'package:sera/ui/add_product/add_product_screen.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen.dart';
import 'package:sera/ui/add_story_post/story/story_screen.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class BottomSheetHelper {
  static BottomSheetHelper? _instance;

  BottomSheetHelper._();

  static BottomSheetHelper instance() {
    _instance ??= BottomSheetHelper._();
    return _instance!;
  }

  BuildContext? _context;

  void hideSheet() {
    final context = _context;
    if (context == null) return;
    Navigator.pop(context);

    _context = null;
  }

  void injectContext(BuildContext context) => _context = context;





  void showAddPostSheet(
      BuildContext context, VoidCallback onSaveBoatClosure) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SafeArea(
            child:Container(
                  width: context.mediaSize.width,
                  padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppStrings.CREATE,
                            style: textTheme.bodySmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: BaseConstant.signupSliderColor)),
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddStoryScreen.route,
                                  arguments: true);
                            },
                            child: Row(children: [
                              Image.asset('assets/3x/new_story.png',
                                  height: 16, width: 16, fit: BoxFit.contain),
                              const SizedBox(width: 15),
                              Text(AppStrings.NEW_STORY,
                                  style: textTheme.titleMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface))
                            ])),
                        const SizedBox(height: 10),
                        const Divider(
                            color: BaseConstant.signupSliderColor,
                            thickness: 1.0),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddStoryPostScreen.route,
                                );
                            },
                            child: Row(children: [
                              Image.asset('assets/3x/new_post.png',
                                  height: 16, width: 16, fit: BoxFit.contain),
                              const SizedBox(width: 15),
                              Text(AppStrings.NEW_POST,
                                  style: textTheme.titleMedium!.copyWith(
                                      fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface))
                            ])),
                        const SizedBox(height: 10),
                        const Divider(
                            color: BaseConstant.signupSliderColor,
                            thickness: 1.0),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AddProductScreen.route,
                              );
                            },
                            child: Row(children: [
                              Image.asset('assets/3x/add_new_products.png',
                                  height: 16, width: 16, fit: BoxFit.contain),
                              const SizedBox(width: 15),
                              Text(AppStrings.ADD_NEW_PRODUCTS,
                                  style: textTheme.titleMedium!.copyWith(
                                      fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface))
                            ])),
                        const SizedBox(height: 10),
                        const Divider(
                            color: BaseConstant.signupSliderColor,
                            thickness: 1.0),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AddCollection.route,
                              );
                            },
                            child: Row(children: [
                              Image.asset('assets/3x/add_new_collection.png',
                                  height: 16, width: 16, fit: BoxFit.contain),
                              const SizedBox(width: 15),
                              Text(AppStrings.ADD_NEW_COLLECTION,
                                  style: textTheme.titleMedium!.copyWith(
                                      fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface))
                            ])),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                      ])));
        });
  }
}
