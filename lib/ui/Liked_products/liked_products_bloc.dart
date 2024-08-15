import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/Liked_products/liked_products_state.dart';

class LikedProductsBloc extends Cubit<LikedProductsState> {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  LikedProductsBloc() : super(const LikedProductsState.initial());

//..................... GET Like Products  .................//

  Future<IBaseResponse> getLikeProducts() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getlikeProducts(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          likedProductsData: Data(data: response.products),
        ));
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

// //..................... ADD Like Products  .................//

//   Future<void> addFavProduct(productId, isfav, context, index) async {
//     final user = await _sharedPreferenceHelper.user;
//     if (user != null) {
//       try {
//         final response = await _sharedWebService.likeProduct(
//           user.id,
//           productId,
//           isfav,
//         );

//         if (response.status && response.message != '') {
//           final data = (state.likedProductsData
//                   as Data<List<>?>?)
//               ?.data;
//           // Check if data is not null and the index is within the bounds of the list.
//           if (data != null &&
//               index >= 0 &&
//               index < data.length &&
//               response.message.toString().contains('Favourite')) {
//             data[index].isFavourite = true;
//             // Emit a new state with the updated data.
//             emit(state.copyWith(likedProductsData: Data(data: data)));
//           } else if (data != null &&
//               index >= 0 &&
//               index < data.length &&
//               response.message.toString().contains('Unfavourite')) {
//             data[index].isFavourite = false;
//             // Emit a new state with the updated data.
//             emit(state.copyWith(likedProductsData: Data(data: data)));
//           }
//           _snackbarHelper
//             ..injectContext(context)
//             ..showSnackbar(
//                 snackbarMessage: SnackbarMessage(
//                     content: response.message.toString(),
//                     isLongMessage: false,
//                     isForError: false));
//         } else {}
//       } catch (error) {
//         // log(error.toString());
//       }
//     }
//   }





  @override
  Future<void> close() {
    return super.close();
  }
}
