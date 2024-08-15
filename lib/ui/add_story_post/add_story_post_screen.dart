// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_story_post/post/post_review_screen.dart';
import 'package:sera/util/base_constants.dart';
import 'package:path/path.dart' as path;
import '../../util/app_strings.dart';
import '../common/app_bar.dart';
import 'add_story_post_screen_bloc.dart';
import 'add_story_post_screen_state.dart';

class AddStoryPostScreen extends StatelessWidget {
  static const String route = '/add_post_screen';
  const AddStoryPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<AddStoryPostBloc>();
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: CustomAppBar(
            isbottom: true,
            elevation: 0.0,
            backgroundColor: theme.colorScheme.onPrimary,
            iscenterTitle: true,
            title: Text(AppStrings.ADD_POST,
                style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios,
                    color: theme.colorScheme.secondary, size: 20)),
            onLeadingPressed: () => Navigator.pop(context)),
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
                _buildMediaButton(CupertinoIcons.textbox, 'Text', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostReviewScreen(
                                path: "",
                              )));
                }, context),
                _buildMediaButton(CupertinoIcons.camera, 'Camera', () async {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostReviewScreen(
                                  path: image.path,
                                )));
                  }

                  // bloc.isStory
                  //     ? Navigator.pushNamed(context, StoryReviewScreen.route,
                  //         arguments: bloc.isStory)
                }, context)
              ])),
          BlocBuilder<AddStoryPostBloc,AddStoryPostState>(
            builder: (context,state) {
        return      state.optionsIndex==0?
               const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Photos',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))))
                              :const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Videos',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))));

            }
          ),
          Expanded(child: BlocBuilder<AddStoryPostBloc, AddStoryPostState>(
              builder: (context, state) {
            if (state.optionsIndex == 0) {
              return BlocBuilder<AddStoryPostBloc, AddStoryPostState>(
                  builder: (context, state) => state.galleryImages.isEmpty
                      ?  Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('No Photos Found!',
                            style: textTheme.titleMedium!
                                .copyWith(
                                    color: theme
                                        .colorScheme.error)),
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
                                                      PostReviewScreen(
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
              return BlocBuilder<AddStoryPostBloc, AddStoryPostState>(
                  builder: (context, state) => state.galleryVideos.isEmpty
                      ?   Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('No Videos Found!',
                            style: textTheme.titleMedium!
                                .copyWith(
                                    color: theme
                                        .colorScheme.error)),
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
            }
            return Container(
              color: Colors.limeAccent,
            );
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
