import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:sera/ui/add_story_post/story/story_state.dart';

class AddStoryBloc extends Cubit<AddStoryState> {
  SharedWebService sharedWebService = SharedWebService.instance();
  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  TextEditingController captionController = TextEditingController();

  AddStoryBloc() : super(const AddStoryState.initial()) {
    _fetchGalleryImages();
    _fetchGalleryVideos();
    getUserFromSharedPref();
  }

  Future<String> saveImageToTempDir(
      Uint8List imageData, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageData);
    return file.path;
  }

  Future<void> _fetchGalleryImages() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 1, size: 30);
        emit(state.copyWith(galleryImages: photos));
      } else {
        emit(state.copyWith(galleryImages: []));
      }
    } else {
      PhotoManager.openSetting();
    }
  }

// Future<void> _fetchGalleryVideos() async {
//   final PermissionState permission = await PhotoManager.requestPermissionExtend();
//   if (permission.isAuth) {
//     List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
//       type: RequestType.video,
//       onlyAll: true,
//     );

//     // Ensure that albums are fetched
//     if (albums.isNotEmpty) {
//       // Fetch all videos in the album
//       List<AssetEntity> videos = await albums[0].getAssetListPaged(page: 0, size: 100);

//       // Emit state with fetched videos or handle accordingly
//       emit(state.copyWith(galleryVideos: videos));

//       // Debugging print statement
//       print('Number of videos fetched: ${videos.length}');
//     } else {
//       print('No video albums found.');
//     }
//   } else {
//     // Handle permission not granted
//     PhotoManager.openSetting();
//   }
// }

  Future<void> _fetchGalleryVideos() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.video,
        onlyAll: true,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> videos =
            await albums[0].getAssetListPaged(page: 0, size: 100);
        List<AssetEntity> filteredVideos = [];
        for (var video in videos) {
          final duration = await video.videoDuration; // Get the video duration
          if (duration.inSeconds <= 15) {
            filteredVideos.add(video);
          }
        }

        emit(state.copyWith(galleryVideos: filteredVideos));
      } else {
        emit(state.copyWith(galleryVideos: []));
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  updateOptionsIndex(int currentIndex) {
    emit(state.copyWith(optionsIndex: currentIndex));
  }

  void updateSelectedProduct(value) {
    emit(state.copyWith(selectProductId: value));
  }



  Future<void> getUserFromSharedPref() async {
    final user = await sharedPreferenceHelper.user;
    if (user == null) return;
    emit(state.copyWith(currentUserData: Data(data: user)));
  }


  Future<IBaseResponse> addStory({filePath,caption}) async {
    final user = await sharedPreferenceHelper.user;
    try {
      final response = await sharedWebService.addStory(
        appUserId: user!.id!,
        filePath: filePath,
      );
      if (response.status == true) {}
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }
}
