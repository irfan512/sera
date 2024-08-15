import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/ui/cart/cart_state.dart';

class CartScreenBloc extends Cubit <CartScreenState> {
 CartScreenBloc() : super(const CartScreenState.initial());

////////////////// CHOOSE YOURSELF //////////////////////
  void updateSizeIndex(value) {
    emit(state.copyWith(sizeIndex: value));
  }

  void updateLengthIndex(value) {
    emit(state.copyWith(lengthIndex: value));
  }
}
