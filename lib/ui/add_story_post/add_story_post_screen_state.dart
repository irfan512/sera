import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sera/data/meta_data.dart';

class AddStoryPostState extends Equatable {
  final int optionsIndex;
  final bool isStory;
  final List<AssetEntity> galleryImages;
  final List<AssetEntity> galleryVideos;
  final DataEvent productData;
  final int selectProductId;


  const AddStoryPostState({
    required this.optionsIndex,
    required this.isStory,
    required this.galleryImages,
    required this.galleryVideos,
    required this.productData,
    required this.selectProductId,
   
  });

  const AddStoryPostState.initial()
      : this(
          optionsIndex: 0,
          selectProductId: 0,
          isStory: false,
          productData: const Initial(),
          galleryImages: const [],
          galleryVideos: const [],
         
        );

  AddStoryPostState copyWith({
    int? optionsIndex,
    bool? isStory,
    List<AssetEntity>? galleryImages,
    List<AssetEntity>? galleryVideos,
    DataEvent? productData,
    int? selectProductId,
   
  }) =>
      AddStoryPostState(
        optionsIndex: optionsIndex ?? this.optionsIndex,
        selectProductId: selectProductId ?? this.selectProductId,
        productData: productData ?? this.productData,
        isStory: isStory ?? this.isStory,
        galleryImages: galleryImages ?? this.galleryImages,
        galleryVideos: galleryVideos ?? this.galleryVideos,
      

      );

  @override
  List<Object> get props => [
        optionsIndex,
        selectProductId,
        productData,
        isStory,
        galleryImages,
        galleryVideos,
      
      ];

  @override
  bool get stringify => true;
}
