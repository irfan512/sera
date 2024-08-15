import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class LikedProductsState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool isMenSelect;
  final DataEvent likedProductsData;
  const LikedProductsState({
    required this.pagerIndex,
    required this.errorText,
    required this.isMenSelect,
    required this.likedProductsData,
  });

  const LikedProductsState.initial()
      : this(
          pagerIndex: 0,
          likedProductsData: const Initial(),
          errorText: '',
          isMenSelect: false,
        );

  LikedProductsState copyWith({
    bool? isMenSelect,
    int? pagerIndex,
    String? errorText,
    DataEvent? likedProductsData,
  }) =>
      LikedProductsState(
        likedProductsData: likedProductsData ?? this.likedProductsData,
        isMenSelect: isMenSelect ?? this.isMenSelect,
        pagerIndex: pagerIndex ?? this.pagerIndex,
        errorText: errorText ?? this.errorText,
      );

  @override
  List<Object> get props => [
        isMenSelect,
        pagerIndex,
        errorText,
        likedProductsData,
      ];

  @override
  bool get stringify => true;
}
