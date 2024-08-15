import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/main/nav_items/analysis/analysis_screen.dart';
import 'package:sera/ui/main/nav_items/vendors_screen.dart';
import 'package:sera/ui/main/nav_items/vendor_profile/vendor_profile.dart';
import 'package:sera/util/app_strings.dart';
import 'package:video_player/video_player.dart';
import '../../helper/shared_preference_helper.dart';
import 'main_state.dart';
import 'nav_items/favorite/favourit_screen.dart';
import 'nav_items/home/home_screen.dart';
import 'nav_items/search_screen.dart';
import 'nav_items/profile_screen.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  BuildContext? textFieldContext;
  Key inputKey = GlobalKey();
  final GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController filterSearchController = TextEditingController();

  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();
  final SnackbarHelper snackbarHelper = SnackbarHelper.instance();
  final TextEditingController orderStatusController = TextEditingController();

  static const _filterSearchKeyNavigationKey =
      PageStorageKey(VendorsListScreen.key_title);
  static const _searchKeyNavigationKey = PageStorageKey(SearchScreen.key_title);
  static const _favouriteKeyNavigationKey =
      PageStorageKey(FavouriteScreen.key_title);
  static const _profileScreenNavigationKey =
      PageStorageKey(ProfileScreen.key_title);
  static const _homeScreenNavigationKey = PageStorageKey(HomeScreen.key_title);
  static const _analysisScreenNavigationKey =
      PageStorageKey(AnalysisScreen.key_title);
  static const _vendorProfileScreenNavigationKey =
      PageStorageKey(VendorProfileScreen.key_title);

  final bottomMap = <PageStorageKey<String>, Widget>{};
  bool? isHaveLocationPermission = false;
  MainScreenBloc() : super(MainScreenState.initial()) {
    _initializeUserType();
    getUserFromSharedPref();
    getAllCategory();
    getAllVendors();
    getCollection();
    getAllProductByUserId();
    getAllPostByUserId();
    getallProduccts();
    getAllStories();
    getLikeProducts();
  }

  Future<void> _initializeUserType() async {
    String usertype = _sharedPreferenceHelper.getUserType() ?? '';
    log(usertype);
    bottomMap[_filterSearchKeyNavigationKey] =
        const VendorsListScreen(key: _filterSearchKeyNavigationKey);
    bottomMap[_searchKeyNavigationKey] =
        const SearchScreen(key: _searchKeyNavigationKey);
    if (usertype == 'Customer') {
      bottomMap[_favouriteKeyNavigationKey] =
          const FavouriteScreen(key: _favouriteKeyNavigationKey);
    } else if (usertype == 'Vendor' || usertype == 'vendor') {
      bottomMap[_analysisScreenNavigationKey] =
          const AnalysisScreen(key: _analysisScreenNavigationKey);
    }
    if (usertype == 'Customer') {
      bottomMap[_profileScreenNavigationKey] =
          const ProfileScreen(key: _profileScreenNavigationKey);
    } else if (usertype == 'Vendor' || usertype == 'vendor') {
      bottomMap[_vendorProfileScreenNavigationKey] =
          const VendorProfileScreen(key: _vendorProfileScreenNavigationKey);
    }
    bottomMap[_homeScreenNavigationKey] =
        const HomeScreen(key: _homeScreenNavigationKey);
    emit(state.copyWith(usertype: usertype));
  }

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateEmailValidation(bool value, String errorText) =>
      emit(state.copyWith(emailValidate: value, errorText: errorText));

  void updateMessageError(bool value, String errorText) =>
      emit(state.copyWith(messageError: value, errorText: errorText));

  void updateNameError(bool value, String errorText) =>
      emit(state.copyWith(nameError: value, errorText: errorText));

  void updateImageError(bool value, String errorText) =>
      emit(state.copyWith(nameError: value, errorText: errorText));
  void handleImageSelectionContactus(XFile file) =>
      emit(state.copyWith(fileDataEvent: Data(data: file)));

  bool isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void updateVendorOrderIndex(int index) {
    if (state.vendorOrderIndex == index) return;
    emit(state.copyWith(vendorOrderIndex: index));
  }

  void updateVendorSalesIndex(int index) {
    if (state.vendorOrderIndex == index) return;
    emit(state.copyWith(vendorSalesIndex: index));
  }

  void updateVendorProfileIndex(int index) {
    if (state.vendorProfileItemIndex == index) return;
    emit(state.copyWith(vendorProfileItemIndex: index));
  }

  void updateVendorAnalysisIndex(int index) {
    if (state.vendorAnalysisScreen == index) return;
    emit(state.copyWith(vendorAnalysisScreen: index));
  }

  void updateOrderSelectedIndex(int index) {
    emit(state.copyWith(orderStatusSelectedValue: index));
  }

  List orderDataList = [
    AppStrings.PENDING,
    AppStrings.PREPARING,
    AppStrings.READY_FOR_PICKUP,
    AppStrings.OUT_OF_DELIVERY,
    AppStrings.DELIVERED,
  ];

  List saleDataList = [
    AppStrings.THIS_MONTH,
    AppStrings.LAST_30_DAYS,
    AppStrings.LAST_60_DAYS,
    AppStrings.LAST_90_DAYS,
  ];
  List analysisScreen = [
    AppStrings.ORDERS,
    AppStrings.SALES_ANALYSIS,
  ];
  List vendorProfileItems = [
    AppStrings.POST,
    AppStrings.PRODUCT,
    AppStrings.COLLECTION
  ];

  Map<int, String> orderStatusList = {
    0: 'Pending',
    1: 'Preparing',
    2: 'Ready for pickup',
    3: 'Out of delivery',
    4: 'Delivered',
  };

  Map<int, String> productFilterList = {
    0: 'All Products',
    1: 'Newest Items',
    2: 'Oldest Items',
    3: 'Price: Low to High',
    4: 'Price: High to Low',
  };

  void toggledIsSearchSuggestion(bool value) =>
      emit(state.copyWith(isSearchSuggestion: value));

  void updateFilterIndexValue(index) =>
      emit(state.copyWith(filterIndex: index));
  void toggleOffersActive(bool value) {
    emit(state.copyWith(isActiveOffers: value));
  }

  Future<void> getUserFromSharedPref() async {
    final user = await _sharedPreferenceHelper.user;
    if (user == null) return;
    emit(state.copyWith(currentUserData: Data(data: user)));
  }

  Widget getNavigationWidget(int index) {
    log(state.usertype.toString());
    switch (index) {
      case 0:
        return const VendorsListScreen(key: _filterSearchKeyNavigationKey);
      case 1:
        return const SearchScreen(key: _searchKeyNavigationKey);
      case 2:
        if (state.usertype == "Customer") {
          return const FavouriteScreen(key: _favouriteKeyNavigationKey);
        } else if (state.usertype == "Vendor" || state.usertype == "vendor") {
          return const AnalysisScreen(key: _analysisScreenNavigationKey);
        } else {
          return const SizedBox();
        }
      case 3:
        if (state.usertype == "Customer") {
          return const ProfileScreen(key: _profileScreenNavigationKey);
        } else if (state.usertype == "Vendor" || state.usertype == "vendor") {
          return const VendorProfileScreen(
              key: _vendorProfileScreenNavigationKey);
        } else {
          return const SizedBox();
        }
      case 4:
        return const HomeScreen(key: _homeScreenNavigationKey);
      default:
        return const SizedBox();
    }
  }

  void handleOnSliderPageChange(int index) {
    if (index > 4 || index < 0) return;
    final pageStorageKey = bottomMap.keys.elementAt(index);
    final sliderItem = bottomMap[pageStorageKey];
    if (sliderItem == null || sliderItem is SizedBox) {
      final newSliderItem = getNavigationWidget(index);
      bottomMap[pageStorageKey] = newSliderItem;
    }
    emit(state.copyWith(index: index));
  }

// Method to get user type
  String? getUserType() {
    return _sharedPreferenceHelper.getUserType();
  }

//..................  Get All Collections  ...................//

  Future<IBaseResponse> getCollection() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getCollections(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          collectionsData: Data(data: response.collections),
          collectionLength: response.collections!.length,
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

  //..................  Get All Category  ...................//

  Future<IBaseResponse> getCategories() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getCollections(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          collectionsData: Data(data: response.collections),
          collectionLength: response.collections!.length,
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

//..................... GET ALL VENDORS .................//

  Future<IBaseResponse> getAllVendors() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.allVendors(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          vendorsData: Data(data: response.vendors),
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

void clearSearch() {
  emit(state.copyWith(filtersVendorData: 
  Error(exception:Exception())
  ));
  searchController.clear(); // This will clear the search field UI as well
}



void searchVendors(String query) {
  final data = state.vendorsData;
  if (data is Data && data.data != null) {
    final vendorsList = data.data as List<UserDataModel>;
    if (query.isEmpty) {
      // If the search query is empty, show the full list
      emit(state.copyWith(
        filtersVendorData: Data(data: vendorsList),
      ));
    } else {
      // Filter vendors based on the query
      final filteredVendors = vendorsList.where((vendor) {
        final vendorName = vendor.firstName?.toLowerCase() ?? '';
        return vendorName.contains(query.toLowerCase());
      }).toList();

      emit(state.copyWith(
        filtersVendorData: Data(data: filteredVendors),
      ));
    }
  } else {
    // Handle the case where vendorsData is not available or is not of type Data
    emit(state.copyWith(
      filtersVendorData: Data(data: []),  // Empty list or handle accordingly
    ));
  }
}




//..................... GET ALL Prodcuts .................//
  Future<IBaseResponse> getallProduccts() async {
    try {
      final response = await _sharedWebService.getAllProducts();
      if (response.status == true) {
        emit(state.copyWith(
          allProductsData: Data(data: response.products),
          filteredProductsData:  Data(data: response.products),
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }
//.....................  ALL Prodcuts .................//

void filterProductsByCategory(int categoryId) {
  final allProducts = state.allProductsData;
    if (categoryId == 0) {
      log(".///////////////////////////////////////.");
  final allProducts = state.allProductsData;
    emit(state.copyWith(
      filteredProductsData: allProducts
    ));
  }
  else if (allProducts is Data) {
    final filteredProducts = allProducts.data.where((product) {
      return product.categoryId == categoryId;
    }).toList();

    emit(state.copyWith(
      filteredProductsData: Data(data: filteredProducts),
    ));
  }
}







//..................... GET ALL Stories .................//
  Future<IBaseResponse> getAllStories() async {
    try {
      final response = await _sharedWebService.getAllStories();
      if (response.status == true) {
        emit(state.copyWith(
          getAllStories: Data(data: response.stories),
        ));
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

//..................... GET ALL Category  .................//
  Future<IBaseResponse> getAllCategory() async {
    final previousUser = await _sharedPreferenceHelper.user;

    try {
      final response = await _sharedWebService.getAllCategory(id: previousUser!.id );
      if (response.status == true) {
        emit(state.copyWith(
          allCategories:  response.categories),
        );
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }



//.................... GET ALL POST .....................//
  Future<void> getAllPostsApi({required int offset}) async {
    final previousUser = await _sharedPreferenceHelper.user;
    if (previousUser != null) {
      try {
        final response = await _sharedWebService.getAllPost(
            // offset: offset,
            );
        if (response.status == true && response.posts != null) {
          final newOffset = offset + response.posts!.length;
          List<PostModel> newPosts = response.posts!;

          if (state.getpostsdata is Data) {
            final existingData =
                (state.getpostsdata as Data<List<PostModel>?>?)?.data ?? [];

            // Remove duplicates by checking if new posts already exist in existingData
            newPosts = newPosts
                .where((post) => !existingData
                    .any((existingPost) => existingPost.id == post.id))
                .toList();

            final combinedData = [...existingData, ...newPosts];
            emit(state.copyWith(
              getpostsdata: Data(data: combinedData),
              homePostsOffset: newOffset,
            ));
          } else {
            emit(state.copyWith(
              getpostsdata: Data(data: newPosts),
              homePostsOffset: newOffset,
            ));
          }
        } else {
          emit(state.copyWith(getpostsdata: Error(exception: Exception())));
        }
      } catch (error) {
        emit(state.copyWith(getpostsdata: Error(exception: Exception())));
      }
    }
  }

//..................... GET Like Products  .................//

  Future<IBaseResponse> getLikeProducts() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getlikeProducts(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          likeProductsList: Data(data: response.products),
        ));
      }
      return response;
    } catch (error) {

      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

//..................... GET ALL Prodcuts .................//
  // Future<IBaseResponse> getAllPostByUserId() async {
  //   final user = await _sharedPreferenceHelper.user;
  //   try {
  //     final response =
  //         await _sharedWebService.getAllPostByUserId(id: user!.id!);
  //     if (response.status == true) {
  //       emit(state.copyWith(
  //         vendorposts: Data(data: response.posts),
  //         postLength: response.posts!.length,
  //       ));
  //     }
  //     return response;
  //   } catch (error) {
  //     log(error.toString());
  //     return StatusMessageResponse(status: false, message: "Invalid Data");
  //   }
  // }

Future<IBaseResponse> getAllPostByUserId() async {
  final user = await _sharedPreferenceHelper.user;
  try {
    final response = await _sharedWebService.getAllPostByUserId(id: user!.id!);
    if (response.status == true) {
      // 1. Separate videos from the list of posts
      final videoPosts = response.posts!.where((post) => isVideo(post)).toList();
      // 2. Initialize a list to store the video controllers
      List<VideoPlayerController> videoControllers = [];
      // 3. Initialize each video controller and add it to the list
      for (var post in videoPosts) {
        final controller = VideoPlayerController.networkUrl( Uri.parse(post.videoUrl!));
        await controller.initialize(); // Await the initialization
        videoControllers.add(controller);
      }
      // 4. Emit the state with the updated list of video controllers
      emit(state.copyWith(
        vendorposts: Data(data: response.posts),
        postLength: response.posts!.length,
        // videoPosts: videoPosts,          // List of video posts
        videoControllers: videoControllers, // List of initialized controllers
      ));
    }
    return response;
  } catch (error) {
    log("EEEEEEEEEEEEEEEEEEEEEEEEEEEEE$error");
    return StatusMessageResponse(status: false, message: "Invalid Data");
  }
}

// Helper method to check if a post is a video
bool isVideo(PostModel post) {
  return post.videoUrl!=null; // or based on file extension
}




















//..................... GET ALL Prodcuts .................//
  Future<IBaseResponse> getAllProductByUserId() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response =
          await _sharedWebService.getAllProductsByUserId(id: user!.id!);
      if (response.status == true) {
        emit(state.copyWith(
          vendorProducts: Data(data: response.products),
          productLength: response.products!.length,
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }







  void logout() {
    _sharedPreferenceHelper.clear();
  }

  @override
  Future<void> close() {
    orderStatusController.dispose();
    _sharedPreferenceHelper.clear();
    logout();
    return super.close();
  }
}
