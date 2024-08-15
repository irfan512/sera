import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/add_story_post/story/story_bloc.dart';
import 'package:sera/ui/add_story_post/story/story_state.dart';
import 'package:sera/util/app_strings.dart';

class StoryReviewScreen extends StatelessWidget {
  static const String route = '/story_review_screen';
  final String? path;
  bool? isVideo;
  StoryReviewScreen({super.key, this.isVideo, this.path});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  TextEditingController captionController = TextEditingController();

  Future<void> _addStory(AddStoryBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addStory(filePath: path, caption: "");
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
          () => _addStory(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final size = context.mediaSize;
    final bloc = context.read<AddStoryBloc>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                context.isDarkTheme ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                context.isDarkTheme ? Brightness.dark : Brightness.light),
        child: Scaffold(
            floatingActionButton: FloatingActionButton.small(
                elevation: 2.0,
                backgroundColor: theme.colorScheme.surface,
                shape: const CircleBorder(),
                onPressed: () {
                  _addStory(bloc, context, _dialogHelper);
                },
                child: Icon(Icons.add, color: theme.colorScheme.onSurface)),
            body: Stack(children: [
              SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.file(File(path!), fit: BoxFit.cover)),
              Positioned(
                  top: kToolbarHeight + 5,
                  left: 30,
                  child: BlocBuilder<AddStoryBloc, AddStoryState>(
                      builder: (context, state) {
                    final data = state.currentUserData;
                    if (data is Data) {
                      final userData = data.data as UserDataModel;

                      return Row(children: [
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
                                    color: theme.colorScheme.onPrimary,
                                    width: 2.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "$pictureUrl${userData.profileImage!}"),
                                    fit: BoxFit.cover))),
                        const SizedBox(width: 6),
                        Text("${userData.firstName} ${userData.lastName}",
                            style: textTheme.titleMedium!.copyWith(
                                fontSize: 14, color: theme.colorScheme.surface))
                      ]);
                    } else {
                      return const SizedBox();
                    }
                  }))
            ])));
  }
}
