import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class ProductDetailState extends Equatable {
  final String sizeIndex;
  final String lengthIndex;
  final DataEvent productDetail;

  const ProductDetailState({
    required this.sizeIndex,
    required this.lengthIndex,
    required this.productDetail,
  });

  const ProductDetailState.initial()
      : this(
          sizeIndex: "",
          lengthIndex: "",
          productDetail: const Initial(),
        );

  ProductDetailState copyWith({
    String? sizeIndex,
    DataEvent? productDetail,
    String? lengthIndex,
  }) =>
      ProductDetailState(
        productDetail: productDetail ?? this.productDetail,
        sizeIndex: sizeIndex ?? this.sizeIndex,
        lengthIndex: lengthIndex ?? this.lengthIndex,
      );

  @override
  List<Object> get props => [
        sizeIndex,
        productDetail,
        lengthIndex,
      ];

  @override
  bool get stringify => true;
}
