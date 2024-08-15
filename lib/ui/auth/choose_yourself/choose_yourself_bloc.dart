import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_state.dart';

class ChooseScreenBloc extends Cubit<ChooseScreenState> {
  ChooseScreenBloc() : super(const ChooseScreenState.initial());

  // Initialize SharedPreferenceHelper
  final _sharedPreferenceHelper = SharedPreferenceHelper.instance();
////////////////// CHOOSE YOURSELF //////////////////////
  void toogleCustomerSelect(value) async {
    emit(state.copyWith(isCustomerSelect: value));
    if (state.isCustomerSelect == true) {
      await _sharedPreferenceHelper.setUserType('Customer');
    }
  }

  void toogleVendorSelect(value) async {
    emit(state.copyWith(isVendorSelect: value));
    if (state.isVendorSelect == true) {
      await _sharedPreferenceHelper.setUserType('Vendor');
    }
  }
}
