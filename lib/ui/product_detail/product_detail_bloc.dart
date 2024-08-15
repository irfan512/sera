import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/product_detail/product_detail_state.dart';

class ProductDetailBloc extends Cubit<ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState.initial());

////////////////// CHOOSE YOURSELF //////////////////////
  void updateSizeIndex(value) {
    emit(state.copyWith(sizeIndex: value));
  }

  void updateLengthIndex(value) {
    emit(state.copyWith(lengthIndex: value));
  }

  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();
  final SnackbarHelper snackbarHelper = SnackbarHelper.instance();

  Future<IBaseResponse> productById(id) async {
    // final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getProductById(
        id: id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          productDetail: Data(data: response.products),
        ));
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }
}
