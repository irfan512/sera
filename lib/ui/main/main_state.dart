import 'package:equatable/equatable.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/meta_data.dart';
import 'package:video_player/video_player.dart';

class MainScreenState extends Equatable {
  final bool imageError;
  final int index;
  final bool isPlacesListView;
  final int filterIndex;
  final DataEvent filterData;
  final bool topRatedSwitch;
  final bool nearbyMeSwitch;
  final bool mostSearchSwitch;
  final bool isFilterClicked;
  final bool isSearchSuggestion;
  final bool isSubscribed;
  final bool isActiveOffers;
  final DataEvent getAllStories;
  final DataEvent allProductsData;
  final List<bool> isFavIcon;
  final double locationlat;
  final double locationlong;
  final DataEvent collectionsData;
  final String errorText;
  final bool emailValidate;
  final bool nameError;
  final bool messageError;
  final bool isPasswordShown;
  final DataEvent fileDataEvent;
  final  List<AllCategoriesModel>  allCategories;
  final DataEvent vendorsData;
  final String usertype;
  final int vendorOrderIndex;
  final int vendorAnalysisScreen;
  final int vendorProfileItemIndex;
  final int vendorSalesIndex;
  final int orderStatusSelectedValue;
  final DataEvent getpostsdata;
  final DataEvent currentUserData;
  final int homePostsOffset;
  final DataEvent likeProductsList;
  final DataEvent vendorposts;
  final DataEvent vendorProducts;
  final int collectionLength;
  final int productLength;
  final int postLength;
  final DataEvent filtersVendorData;
  final DataEvent filteredProductsData;
  final List <VideoPlayerController> videoControllers;

  const MainScreenState({
    required this.videoControllers,
    required this.collectionLength,
    required this.productLength,
    required this.postLength,
    required this.vendorposts,
    required this.filterData,
    required this.likeProductsList,
    required this.currentUserData,
    required this.homePostsOffset,
    required this.getpostsdata,
    required this.orderStatusSelectedValue,
    required this.vendorProfileItemIndex,
    required this.vendorAnalysisScreen,
    required this.usertype,
    required this.filterIndex,
    required this.vendorsData,
    required this.imageError,
    required this.fileDataEvent,
    required this.index,
    required this.isPlacesListView,
    required this.topRatedSwitch,
    required this.nearbyMeSwitch,
    required this.mostSearchSwitch,
    required this.isFilterClicked,
    required this.isSubscribed,
    required this.isSearchSuggestion,
    required this.isActiveOffers,
    required this.getAllStories,
    required this.allProductsData,
    required this.isFavIcon,
    required this.locationlat,
    required this.locationlong,
    required this.collectionsData,
    required this.errorText,
    required this.nameError,
    required this.isPasswordShown,
    required this.messageError,
    required this.emailValidate,
    required this.allCategories,
    required this.vendorOrderIndex,
    required this.vendorSalesIndex,
    required this.vendorProducts,
    required this.filtersVendorData,
    required this.filteredProductsData,
  });

  MainScreenState.initial()
      : this(
          index: 0,
          videoControllers:const [],
          postLength: 0,
productLength: 0,
collectionLength:0 ,
          vendorposts: const Initial(),
          currentUserData: const Initial(),
          likeProductsList: const Initial(),
          homePostsOffset: 0,
          getpostsdata: const Initial(),
          orderStatusSelectedValue: 0,
          vendorProfileItemIndex: 0,
          filterIndex: 0,
          vendorAnalysisScreen: 0,
          usertype: "",
          imageError: false,
          filterData: const Initial(),
          fileDataEvent: const Initial(),
          vendorsData: const Initial(),
          isPlacesListView: false,
          collectionsData: const Initial(),
          locationlat: 0.0,
          locationlong: 0.0,
          topRatedSwitch: true,
          nearbyMeSwitch: false,
          mostSearchSwitch: false,
          isFilterClicked: false,
          isSubscribed: false,
          isSearchSuggestion: false,
          isActiveOffers: false,
          isFavIcon: [],
          getAllStories: const Initial(),
          allProductsData: const Initial(),
          errorText: '',
          nameError: false,
          isPasswordShown: false,
          messageError: false,
          emailValidate: false,
          allCategories: const [],
          vendorOrderIndex: 0,
          vendorSalesIndex: 0,
          vendorProducts: const Initial(),
          filtersVendorData: const Initial(),
          filteredProductsData:const Initial(),
        );


  MainScreenState copyWith({
    int? vendorProfileItemIndex,
  List<VideoPlayerController>? videoControllers,
    DataEvent? currentUserData,
    DataEvent? vendorposts,
    DataEvent? likeProductsList,
    int? vendorAnalysisScreen,
    DataEvent? fileDataEvent,
    int? filterIndex,
    DataEvent? collectionsData,
    DataEvent? vendorsData,
    DataEvent? filterData,
    bool? imageError,
    int? index,
    bool? isPlacesListView,
    bool? topRatedSwitch,
    bool? nearbyMeSwitch,
    bool? mostSearchSwitch,
    bool? isFilterClicked,
    bool? isSearchSuggestion,
    bool? isSubscribed,
    bool? isActiveOffers,
    DataEvent? getAllStories,
    DataEvent? allProductsData,
    List<bool>? isFavIcon,
    double? locationlong,
    double? locationlat,
    bool? nameError,
    String? errorText,
    bool? isPasswordShown,
    bool? messageError,
    bool? emailValidate,
    List<AllCategoriesModel>? allCategories,
    String? usertype,
    int? vendorOrderIndex,
    int? vendorSalesIndex,
    int? orderStatusSelectedValue,
    DataEvent? getpostsdata,
    int? homePostsOffset,
    DataEvent? vendorProducts,
    int?productLength,
    int?collectionLength,
    int?postLength,
    DataEvent? filtersVendorData,
    DataEvent?filteredProductsData,

  }) =>
      MainScreenState(
        filtersVendorData: filtersVendorData??this.filtersVendorData,
        videoControllers: videoControllers??this.videoControllers,


        postLength: postLength??this.postLength,
        collectionLength: collectionLength??this.collectionLength,
        productLength: productLength??this.productLength,
        homePostsOffset: homePostsOffset ?? this.homePostsOffset,
        vendorposts: vendorposts ?? this.vendorposts,
        likeProductsList: likeProductsList ?? this.likeProductsList,
        currentUserData: currentUserData ?? this.currentUserData,
        orderStatusSelectedValue:
            orderStatusSelectedValue ?? this.orderStatusSelectedValue,
        vendorSalesIndex: vendorSalesIndex ?? this.vendorSalesIndex,
        getpostsdata: getpostsdata ?? this.getpostsdata,
        vendorProfileItemIndex:
            vendorProfileItemIndex ?? this.vendorProfileItemIndex,
        vendorOrderIndex: vendorOrderIndex ?? this.vendorOrderIndex,
        vendorAnalysisScreen: vendorAnalysisScreen ?? this.vendorAnalysisScreen,
        usertype: usertype ?? this.usertype,
        filterData: filterData ?? this.filterData,
        filterIndex: filterIndex ?? this.filterIndex,
        imageError: imageError ?? this.imageError,
        fileDataEvent: fileDataEvent ?? this.fileDataEvent,
        collectionsData: collectionsData ?? this.collectionsData,
        vendorsData: vendorsData ?? this.vendorsData,
        index: index ?? this.index,
        isPlacesListView: isPlacesListView ?? this.isPlacesListView,
        topRatedSwitch: topRatedSwitch ?? this.topRatedSwitch,
        nearbyMeSwitch: nearbyMeSwitch ?? this.nearbyMeSwitch,
        isFilterClicked: isFilterClicked ?? this.isFilterClicked,
        isSearchSuggestion: isSearchSuggestion ?? this.isSearchSuggestion,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        isActiveOffers: isActiveOffers ?? this.isActiveOffers,
        mostSearchSwitch: mostSearchSwitch ?? this.mostSearchSwitch,
        getAllStories: getAllStories ?? this.getAllStories,
        allProductsData: allProductsData ?? this.allProductsData,
        isFavIcon: isFavIcon ?? this.isFavIcon,
        locationlat: locationlat ?? this.locationlat,
        locationlong: locationlong ?? this.locationlong,
        errorText: errorText ?? this.errorText,
        nameError: nameError ?? this.nameError,
        messageError: messageError ?? this.messageError,
        emailValidate: emailValidate ?? this.emailValidate,
        isPasswordShown: isPasswordShown ?? this.isPasswordShown,
        allCategories: allCategories ?? this.allCategories,
        vendorProducts: vendorProducts ?? this.vendorProducts,
        filteredProductsData: filteredProductsData ?? this.filteredProductsData,

      );

  @override
  List<Object?> get props => [
    filteredProductsData,
    videoControllers,
        vendorposts,
        filtersVendorData,
        collectionLength,
        productLength,
        postLength,
        vendorProducts,
        homePostsOffset,
        likeProductsList,
        currentUserData,
        orderStatusSelectedValue,
        getpostsdata,
        vendorSalesIndex,
        vendorProfileItemIndex,
        vendorOrderIndex,
        vendorAnalysisScreen,
        usertype,
        filterIndex,
        vendorsData,
        filterData,
        locationlat,
        locationlong,
        imageError,
        index,
        isPlacesListView,
        nearbyMeSwitch,
        mostSearchSwitch,
        isSubscribed,
        topRatedSwitch,
        isFilterClicked,
        isSearchSuggestion,
        getAllStories,
        isActiveOffers,
        isFavIcon,
        allProductsData,
        collectionsData,
        emailValidate,
        nameError,
        isPasswordShown,
        errorText,
        messageError,
        fileDataEvent,
        allCategories,
      ];
}
