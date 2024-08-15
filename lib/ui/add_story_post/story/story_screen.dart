// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/add_story_post/post/post_review_screen.dart';
import 'package:sera/ui/add_story_post/story/story_bloc.dart';
import 'package:sera/ui/add_story_post/story/story_review_screen.dart';
import 'package:sera/ui/add_story_post/story/story_state.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';
import 'package:path/path.dart' as path;

class AddStoryScreen extends StatelessWidget {
  static const String route = '/add_story_screen';
  const AddStoryScreen({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _addStory(AddStoryBloc bloc, BuildContext context,
      DialogHelper dialogHelper, String caption) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addStory(filePath: "", caption: caption);
      dialogHelper.dismissProgress();
      if (response.status != true) {
        _snackbarHelper
          ..injectContext(context)
          ..showSnackbar(
              snackbarMessage:
                  SnackbarMessage.smallMessageError(content: response.message),
              margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: context.isHaveBottomNotch ? 100 : 90));
        return;
      }
      Navigator.pop(context);
      _snackbarHelper
        ..injectContext(context)
        ..showSnackbar(
            snackbarMessage:
                SnackbarMessage.smallMessage(content: response.message),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _addStory(bloc, context, dialogHelper, caption));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<AddStoryBloc>();
    final size = context.mediaSize;
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: CustomAppBar(
            isbottom: true,
            elevation: 0.0,
            backgroundColor: theme.colorScheme.onPrimary,
            iscenterTitle: true,
            title: Text(AppStrings.ADD_STORY,
                style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios,
                    color: theme.colorScheme.secondary, size: 20)),
            onLeadingPressed: () => Navigator.pop(context)),
        floatingActionButton: FloatingActionButton.small(
            elevation: 2.0,
            backgroundColor: theme.colorScheme.surface,
            shape: const CircleBorder(),
            onPressed: () {
              if (bloc.captionController.text.isNotEmpty) {
                _addStory(
                    bloc, context, _dialogHelper, bloc.captionController.text);
              } else {
                _snackbarHelper
                  ..injectContext(context)
                  ..showSnackbar(
                      snackbarMessage: const SnackbarMessage.smallMessageError(
                          content:
                              "Please enter your content below before posting"),
                      margin: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: context.isHaveBottomNotch ? 100 : 90));
              }
            },
            child: Icon(Icons.add, color: theme.colorScheme.onSurface)),
        body: Column(children: [
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                _buildMediaButton(CupertinoIcons.photo, 'Photo',
                    () => bloc.updateOptionsIndex(0), context),
                _buildMediaButton(CupertinoIcons.play_rectangle, 'Video',
                    () => bloc.updateOptionsIndex(1), context),
                _buildMediaButton(CupertinoIcons.textbox, 'Text',
                    () => bloc.updateOptionsIndex(2), context),
                _buildMediaButton(CupertinoIcons.camera, 'Camera', () async {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryReviewScreen(
                                  path: image.path,
                                )));
                  }
                }, context)
              ])),
          BlocBuilder<AddStoryBloc, AddStoryState>(builder: (context, state) {
            return state.optionsIndex == 0
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Photos',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))))
                : state.optionsIndex == 1
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Videos',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Text',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))));
          }),
          Expanded(child: BlocBuilder<AddStoryBloc, AddStoryState>(
              builder: (context, state) {
            if (state.optionsIndex == 0) {
              return BlocBuilder<AddStoryBloc, AddStoryState>(
                  buildWhen: (p, c) => p.galleryImages != c.galleryImages,
                  builder: (context, state) => state.galleryImages.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No Photos Found!',
                                style: textTheme.titleMedium!
                                    .copyWith(color: theme.colorScheme.error)),
                          ],
                        ))
                      : GridView.builder(
                          // shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemCount: state.galleryImages.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Uint8List?>(
                                future: state.galleryImages[index].originBytes,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    if (state.galleryImages.isEmpty) {
                                      return Center(
                                          child: Text('No Photos Found!',
                                              style: textTheme.titleMedium!
                                                  .copyWith(
                                                      color: theme
                                                          .colorScheme.error)));
                                    }
                                    return InkWell(
                                        onTap: () async {
                                          final fileName = path.basename(
                                              state.galleryImages[index].id);
                                          final imagePath =
                                              await bloc.saveImageToTempDir(
                                            snapshot.data!,
                                            fileName,
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StoryReviewScreen(
                                                        path: imagePath,
                                                      )));
                                        },
                                        child: Image.memory(snapshot.data!,
                                            fit: BoxFit.cover));
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                });
                          }));
            } else if (state.optionsIndex == 1) {
              return BlocBuilder<AddStoryBloc, AddStoryState>(
                  builder: (context, state) => state.galleryVideos.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No Videos Found!',
                                style: textTheme.titleMedium!
                                    .copyWith(color: theme.colorScheme.error)),
                          ],
                        ))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemCount: state.galleryVideos.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Uint8List?>(
                                future:
                                    state.galleryVideos[index].thumbnailData,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    if (state.galleryImages.isEmpty) {
                                      return Center(
                                          child: Text('No Videos Found!',
                                              style: textTheme.titleMedium!
                                                  .copyWith(
                                                      color: theme
                                                          .colorScheme.error)));
                                    }
                                    return InkWell(
                                      onTap: () async {
                                        final videoPath = await state
                                            .galleryVideos[index].file
                                            .then((file) => file!.path);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoDetail(
                                                      videoUrl: videoPath,
                                                    )));
                                      },
                                      child: Image.memory(snapshot.data!,
                                          fit: BoxFit.cover),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                });
                          }));
            } else if (state.optionsIndex == 2) {
              return SizedBox(
                  height: size.height / 8.9,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                          controller: bloc.captionController,
                          maxLines: null,
                          style: textTheme.titleMedium,
                          decoration: InputDecoration(
                              hintText: 'Write a caption...',
                              hintStyle: textTheme.titleSmall!.copyWith(
                                  color: const Color(0xff888f7f),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              border: InputBorder.none))));
            }

            return const SizedBox();
          }))
        ]));
  }

  Widget _buildMediaButton(
      IconData icon, String label, VoidCallback onTap, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
              color: BaseConstant.signupSliderColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12)),
          child: GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                size: 24,
              ))),
    );
  }
}
