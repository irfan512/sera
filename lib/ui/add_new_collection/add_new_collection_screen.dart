// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_bloc.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_state.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class AddCollection extends StatelessWidget {
  static const String route = "_add_collection_screen";
  const AddCollection({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _addCollection(AddCollectionBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addCollection();
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
          () => _addCollection(bloc, context, dialogHelper));
    }
  }



  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final size = context.mediaSize;

    final bloc = context.read<AddCollectionBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.ADD_COLLECTION,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.COLLECTION_NAME,
                      style: textTheme.titleMedium)),
              BlocBuilder<AddCollectionBloc, AddCollectionState>(
                  buildWhen: (previous, current) =>
                      previous.collectionNameValidate !=
                      current.collectionNameValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.collectionNameValidate,
                      radius: 8,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.collectionNameValidate) {
                          bloc.updateCollectionNameValidate(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_COLLECTION_NAME,
                      textInputType: TextInputType.name,
                      controller: bloc.collectionNameController)),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<AddCollectionBloc, AddCollectionState>(
                  builder: (context, state) {
                final data = state.fileDataEvent;

                if (data is Data) {
                  final imageData = data.data as XFile;

                  return Center(
                    child: InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        bloc.handleImageSelection(image);
                      },
                      child: Container(
                        height: 140,
                        width: size.width * .5,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.colorScheme.secondaryContainer)),
                        child: Center(
                          child: Image.file(File(imageData.path)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        bloc.handleImageSelection(image);
                      },
                      child: Container(
                        height: 140,
                        width: size.width * .5,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.colorScheme.secondaryContainer)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/3x/empty_image.png"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(AppStrings.ADD_IMAGE,
                                  style: textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(AppStrings.COLLECTION_COVER,
                      style: textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.primaryContainer))),
              BlocBuilder<AddCollectionBloc, AddCollectionState>(
                  buildWhen: (previous, current) =>
                      previous.errorText != current.errorText,
                  builder: (_, state) {
                    if (state.errorText.isEmpty) {
                      return const SizedBox();
                    }
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        margin: const EdgeInsets.only(bottom: 20, top: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.error)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  color: theme.colorScheme.error),
                              const SizedBox(width: 5),
                              Text(state.errorText,
                                  style: TextStyle(
                                      color: theme.colorScheme.error,
                                      fontFamily: BaseConstant.poppinsRegular,
                                      fontSize: 12))
                            ]));
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: AppStrings.NEXT,
                      onClick: () {
                        context.unfocus();

                        final bool isbrandLogoSelected =
                            bloc.state.fileDataEvent is Data;
                        if (bloc.collectionNameController.text.isEmpty) {
                          bloc.updateCollectionNameValidate(
                              true, AppStrings.COLLECTION_NAME_IS_EMPTY);
                          return;
                        } else if (isbrandLogoSelected == false) {
                          bloc.updateErrorText(
                              AppStrings.COLLECTION_LOGO_IS_EMPTY);
                          return;
                        } else {
                          _addCollection(bloc, context, _dialogHelper);
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
