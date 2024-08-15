import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sera/data/meta_data.dart';

class AddStoryState extends Equatable {
  final int optionsIndex;
  final bool isStory;
  final List<AssetEntity> galleryImages;
  final List<AssetEntity> galleryVideos;
  final DataEvent currentUserData;
  final int selectProductId;


  const AddStoryState({
    required this.optionsIndex,
    required this.isStory,
    required this.galleryImages,
    required this.galleryVideos,
    required this.currentUserData,
    required this.selectProductId,
   
  });

  const AddStoryState.initial()
      : this(
          optionsIndex: 0,
          selectProductId: 0,
          isStory: false,
          currentUserData: const Initial(),
          galleryImages: const [],
          galleryVideos: const [],
         
        );

  AddStoryState copyWith({
    int? optionsIndex,
    bool? isStory,
    List<AssetEntity>? galleryImages,
    List<AssetEntity>? galleryVideos,
    DataEvent? currentUserData,
    int? selectProductId,
   
  }) =>
      AddStoryState(
        optionsIndex: optionsIndex ?? this.optionsIndex,
        selectProductId: selectProductId ?? this.selectProductId,
        currentUserData: currentUserData ?? this.currentUserData,
        isStory: isStory ?? this.isStory,
        galleryImages: galleryImages ?? this.galleryImages,
        galleryVideos: galleryVideos ?? this.galleryVideos,
      

      );

  @override
  List<Object> get props => [
        optionsIndex,
        selectProductId,
        currentUserData,
        isStory,
        galleryImages,
        galleryVideos,
      
      ];

  @override
  bool get stringify => true;
}
