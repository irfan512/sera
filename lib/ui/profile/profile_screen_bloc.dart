import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sera/data/meta_data.dart';

import 'package:sera/helper/shared_preference_helper.dart';

import 'package:sera/ui/profile/profile_screen_state.dart';

class ProfileScreenBloc extends Cubit<ProfileScreenState> {
  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  final PageController pageSliderController = PageController();

  ProfileScreenBloc() : super(const ProfileScreenState.initial()) {
    getUserFromSharedPref();
  }
////////////////// CHOOSE YOURSELF //////////////////////

  Future<void> getUserFromSharedPref() async {
    final user = await sharedPreferenceHelper.user;
    if (user == null) return;
    emit(state.copyWith(
        userImage: user.profileImage!, currentUserData: Data(data: user)));
  }
}
