import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/ui/edit_profile/edit_profile_bloc.dart';
import 'package:sera/ui/edit_profile/edit_profile_state.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class EditProfile extends StatelessWidget {
  static const String route = '/edit_profile_screen';
  DialogHelper get _dialogHelper => DialogHelper.instance();

  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<EditProfileBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.EDIT_PROFILE,
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
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                        builder: (context, state) {
                      final eventData = state.fileDataEvent;
                      ImageProvider image;
                      if (eventData is! Data) {
                        if (state.userImage.isNotEmpty) {
                          image = NetworkImage("$pictureUrl${state.userImage}");
                        } else {
                          image =
                              const AssetImage('assets/3x/profile_picture.png');
                        }
                      } else {
                        final imageData = eventData.data as XFile;
                        image = FileImage(File(imageData.path));
                      }
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: BaseConstant.brandIdentityColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: InkWell(
                        onTap: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          bloc.handleImageSelection(image);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSecondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.FIRST_NAME,
                      style: textTheme.titleMedium)),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                  buildWhen: (previous, current) =>
                      previous.firstNameValidate != current.firstNameValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.firstNameValidate,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.firstNameValidate) {
                          bloc.updateFirstNameValidate(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_FIRST_NAME,
                      textInputType: TextInputType.name,
                      radius: 8,
                      controller: bloc.firstNameController)),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child:
                      Text(AppStrings.LAST_NAME, style: textTheme.titleMedium)),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                  buildWhen: (previous, current) =>
                      previous.lastNameValidate != current.lastNameValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.lastNameValidate,
                      radius: 8,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.lastNameValidate) {
                          bloc.updateLastNameValidate(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_LAST_NAME,
                      textInputType: TextInputType.name,
                      controller: bloc.lastNameController)),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.EMAIL, style: textTheme.titleMedium)),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                  buildWhen: (previous, current) =>
                      previous.emailValidate != current.emailValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.emailValidate,
                      radius: 8,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.emailValidate) {
                          bloc.updateEmailValidate(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_YOUR_EMAIL,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.emailController)),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.MOBILE, style: textTheme.titleMedium)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                    return SizedBox(
                      width: 80,
                      child: PopupMenuButton<String>(
                        color: Colors.white,
                        shadowColor: Colors.transparent,
                        offset: const Offset(0.5, kToolbarHeight),
                        elevation: 0,
                        tooltip: '',
                        splashRadius: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.5,
                            color: theme.colorScheme.secondaryContainer,
                          ),
                        ),
                        constraints: const BoxConstraints(minWidth: 80),
                        position: PopupMenuPosition.over,
                        itemBuilder: (context) {
                          final List<String> itemList = [
                            "+1",
                            "+92",
                          ];
                          List<PopupMenuEntry<String>> menuItems = [];
                          for (int i = 0; i < itemList.length; i++) {
                            menuItems.add(
                              PopupMenuItem<String>(
                                value: itemList[i],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      itemList[i],
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 14,
                                        fontFamily: BaseConstant.poppinsMedium,
                                        color: theme
                                            .colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                    if (i != itemList.length - 1)
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    if (i != itemList.length - 1)
                                      Container(
                                        height:
                                            1, // Adjust divider height as needed
                                        color: theme
                                            .colorScheme.secondaryContainer
                                            .withOpacity(0.2),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return menuItems;
                        },
                        onSelected: (selectedItem) {
                          bloc.mobileCodeController.text = selectedItem;
                        },
                        child: AppTextField(
                          controller: bloc.mobileCodeController,
                          enabled: false,
                          readOnly: true,
                          radius: 8,
                          isError: false,
                          onChanged: (String? value) {
                            if (value == null) return;
                            if (value.isNotEmpty && state.mobileCodeValidate) {
                              bloc.updateMobileCodeValidate(false, '');
                            }
                          },
                          textInputAction: TextInputAction.next,
                          hint: '+1',
                          textInputType: TextInputType.number,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: BlocBuilder<EditProfileBloc, EditProfileState>(
                        buildWhen: (previous, current) =>
                            previous.mobileNumberValidate !=
                            current.mobileNumberValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.mobileNumberValidate,
                            radius: 8,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty &&
                                  state.mobileNumberValidate) {
                                bloc.updateMobileNumberValidate(false, '');
                              }
                            },
                            hint: AppStrings.NUMBER,
                            textInputType: TextInputType.number,
                            controller: bloc.mobileNumberController)),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: AppStrings.UPDATE,
                      onClick: () {
                        context.unfocus();
                        
                        bloc.updateProfile(bloc, context, _dialogHelper);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
