
import 'dart:convert';

abstract class IBaseResponse {
  final bool status;
  final String message;

  IBaseResponse(this.status, this.message);

  @override
  String toString() {
    return 'IBaseResponse{status: $status, message: $message}';
  }
}

class StatusMessageResponse extends IBaseResponse {
  StatusMessageResponse({required bool status, required String message})
      : super(status, message);

  factory StatusMessageResponse.fromJson(Map<String, dynamic> json) {
    final bool status = json.containsKey('status') ? json['status'] : false;
    final String message = json.containsKey('message') ? json['message'] : '';
    return StatusMessageResponse(status: status, message: message);
  }
  @override
  String toString() {
    return 'StatusMessageResponse: {status: $status, message: $message}';
  }
}

class LoginAuthenticationResponse extends StatusMessageResponse {
  final UserDataModel? user;
  LoginAuthenticationResponse(this.user, status, String message)
      : super(status: status, message: message);
  factory LoginAuthenticationResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final userJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return userJson == null
        ? LoginAuthenticationResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : LoginAuthenticationResponse(UserDataModel.fromJson(userJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

class AddUserAddressResponse extends StatusMessageResponse {
  final List<AddressModel>? addresses;
  final AddressModel? address;
  AddUserAddressResponse({
    this.address,
    this.addresses,
    required bool status,
    required String message,
  }) : super(status: status, message: message);
  factory AddUserAddressResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final dataJson = json.containsKey('data') ? json['data'] : null;
    if (dataJson == null) {
      return AddUserAddressResponse(
        address: null,
        addresses: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else if (dataJson is List) {
      List<AddressModel> addresses = dataJson
          .map((addressJson) => AddressModel.fromJson(addressJson))
          .toList();
      return AddUserAddressResponse(
        address: null,
        addresses: addresses,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else {
      AddressModel address = AddressModel.fromJson(dataJson);
      return AddUserAddressResponse(
        address: address,
        addresses: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    }
  }
}

//................. All Vendors .................//
class AllVendorsData extends StatusMessageResponse {
  final List<UserDataModel>? vendors;
  final UserDataModel? vendor;
  AllVendorsData({
    this.vendor,
    this.vendors,
    required bool status,
    required String message,
  }) : super(status: status, message: message);
  factory AllVendorsData.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final dataJson = json.containsKey('data') ? json['data'] : null;
    if (dataJson == null) {
      return AllVendorsData(
        vendor: null,
        vendors: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else if (dataJson is List) {
      List<UserDataModel> addresses = dataJson
          .map((addressJson) => UserDataModel.fromJson(addressJson))
          .toList();
      return AllVendorsData(
        vendor: null,
        vendors: addresses,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else {
      UserDataModel address = UserDataModel.fromJson(dataJson);
      return AllVendorsData(
        vendor: address,
        vendors: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    }
  }
}

//..................... all category .......................//

class AllCategory extends StatusMessageResponse {
  final List<AllCategoriesModel>? categories;

  AllCategory({
    this.categories,
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory AllCategory.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);

    // Safely get the data list and ensure it's of the correct type
    final dataJson = json['data'] as List<dynamic>?;

    List<AllCategoriesModel> categories = dataJson != null
        ? dataJson
            .map((item) =>
                AllCategoriesModel.fromJson(item as Map<String, dynamic>))
            .toList()
        : [];

    return AllCategory(
      categories: categories,
      status: statusMessageResponse.status,
      message: statusMessageResponse.message,
    );
  }
}

//..................... all category .......................//

class GetAllCollectionsMethod extends StatusMessageResponse {
  final List<AllCollectionsModel>? collections;

  GetAllCollectionsMethod({
    this.collections,
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory GetAllCollectionsMethod.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);

    // Safely get the data list and ensure it's of the correct type
    final dataJson = json['data'] as List<dynamic>?;

    List<AllCollectionsModel> collections = dataJson != null
        ? dataJson
            .map((item) =>
                AllCollectionsModel.fromJson(item as Map<String, dynamic>))
            .toList()
        : [];

    return GetAllCollectionsMethod(
      collections: collections,
      status: statusMessageResponse.status,
      message: statusMessageResponse.message,
    );
  }
}

//................. Update Profile .................//

class UpdateProfileResponse extends StatusMessageResponse {
  final UserDataModel? user;
  UpdateProfileResponse(this.user, status, String message)
      : super(status: status, message: message);
  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final userJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return userJson == null
        ? UpdateProfileResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : UpdateProfileResponse(UserDataModel.fromJson(userJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

//................. Update Brand Response  .................//

class UpdateBrandResponse extends StatusMessageResponse {
  final AppUserBrand? brand;
  UpdateBrandResponse(this.brand, status, String message)
      : super(status: status, message: message);
  factory UpdateBrandResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final userJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return userJson == null
        ? UpdateBrandResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : UpdateBrandResponse(AppUserBrand.fromJson(userJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

//..................... all products .......................//

class GetAllProduct extends StatusMessageResponse {
  final List<Product>? products;
  GetAllProduct({
    this.products,
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory GetAllProduct.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    // Safely get the data list and ensure it's of the correct type
    final dataJson = json['data'] as List<dynamic>?;
    List<Product> collections = dataJson != null
        ? dataJson
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList()
        : [];
    return GetAllProduct(
      products: collections,
      status: statusMessageResponse.status,
      message: statusMessageResponse.message,
    );
  }
}



//..................... all products .......................//
class ProductDetailResponse extends StatusMessageResponse {
  final Product? products;
  ProductDetailResponse({
    this.products,
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    // Safely get the data list and ensure it's of the correct type
    final dataJson = json['data'] as Map<String,dynamic>;
  Product productData =
         Product.fromJson(json['data']);
    return ProductDetailResponse(
      products:  productData ,
      status: statusMessageResponse.status,
      message: statusMessageResponse.message,
    );
  }
}

//................. All Posts .................//

class AllPostsData extends StatusMessageResponse {
  final List<PostModel>? posts;
  final PostModel? post;
  AllPostsData({
    this.post,
    this.posts,
    required bool status,
    required String message,
  }) : super(status: status, message: message);
  factory AllPostsData.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final dataJson = json.containsKey('data') ? json['data'] : null;
    if (dataJson == null) {
      return AllPostsData(
        post: null,
        posts: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else if (dataJson is List) {
      List<PostModel> addresses = dataJson
          .map((addressJson) => PostModel.fromJson(addressJson))
          .toList();
      return AllPostsData(
        post: null,
        posts: addresses,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    } else {
      PostModel address = PostModel.fromJson(dataJson);
      return AllPostsData(
        post: address,
        posts: null,
        status: statusMessageResponse.status,
        message: statusMessageResponse.message,
      );
    }
  }
}


///////////////////////////  get all stories  //////////////////

class GetAllStories extends StatusMessageResponse {
  final List<StoryModel>? stories;
  GetAllStories({
    this.stories,
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory GetAllStories.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    // Safely get the data list and ensure it's of the correct type
    final dataJson = json['data'] as List<dynamic>?;
    List<StoryModel> collections = dataJson != null
        ? dataJson
            .map((item) => StoryModel.fromJson(item as Map<String, dynamic>))
            .toList()
        : [];
    return GetAllStories(
      stories: collections,
      status: statusMessageResponse.status,
      message: statusMessageResponse.message,
    );
  }
}



//////////////////////////  User DATA RESPONSE  MODEL  //////////////////////
class UserDataModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? userType;
  dynamic appUserBrandId;
  AppUserBrand? appUserBrand;
  int? id;
  String? createdDate;
  String? modifiedDate;
  dynamic isActive;
  String? profileImage;
  String? countryCode;

  UserDataModel({
    this.firstName,
    this.countryCode,
    this.lastName,
    this.profileImage,
    this.email,
    this.phoneNumber,
    this.password,
    this.userType,
    this.appUserBrandId,
    this.appUserBrand,
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.isActive,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      profileImage: json['image'] ?? "",
      countryCode: json['countryCode'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      password: json['password'] ?? "",
      userType: json['userType'] ?? "",
      id: json['id'] ?? 0,
      createdDate: json['createdDate'] ?? "",
      modifiedDate: json['modifiedDate'] ?? "",
      isActive: json['isActive'] ?? false,
      appUserBrand: json['appUserBrand'] != null
          ? AppUserBrand.fromJson(json['appUserBrand'])
          : null,
      appUserBrandId: json['appUserBrandId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': profileImage??"",
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'password': password,
      'userType': userType,
      'appUserBrandId': appUserBrandId,
      'appUserBrand': appUserBrand,
      'id': id,
      'createdDate': createdDate ?? "",
      'modifiedDate': modifiedDate ?? "",
      'isActive': isActive,
    };
  }

  UserDataModel copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? countryCode,
      String? password,
      String? userType,
      dynamic appUserBrandId,
      dynamic appUserBrand,
      int? id,
      String? createdDate,
      String? modifiedDate,
      bool? isActive,
      String? profileImage}) {
    return UserDataModel(
      profileImage: profileImage ?? this.profileImage,
      firstName: firstName ?? this.firstName,
      countryCode: countryCode ?? this.countryCode,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      appUserBrandId: appUserBrandId ?? this.appUserBrandId,
      appUserBrand: appUserBrand ?? this.appUserBrand,
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      isActive: isActive ?? this.isActive,
    );
  }
}

/////////////////////////  User Brand Model  ///////////////////////

class AppUserBrand {
  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isActive;
  String? headerUrl;
  String? logoUrl;
  String? brandName;
  String? slogan;
  String? targetAudience;
  String? bio;
  String? email;
  String? countryCode;
  String? phoneNumber;

  AppUserBrand({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.isActive,
    this.headerUrl,
    this.logoUrl,
    this.brandName,
    this.slogan,
    this.targetAudience,
    this.bio,
    this.email,
    this.countryCode,
    this.phoneNumber,
  });

  // Factory method to create an instance from JSON
  factory AppUserBrand.fromJson(Map<String, dynamic> json) {
    return AppUserBrand(
      id: json['id'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      isActive: json['isActive'],
      headerUrl: json['headerUrl'],
      logoUrl: json['logoUrl'],
      brandName: json['brandName'],
      slogan: json['slogan'],
      targetAudience: json['targetAudience'],
      bio: json['bio'],
      email: json['email'],
      countryCode: json['countryCode'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
      'isActive': isActive,
      'headerUrl': headerUrl,
      'logoUrl': logoUrl,
      'brandName': brandName,
      'slogan': slogan,
      'targetAudience': targetAudience,
      'bio': bio,
      'email': email,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
    };
  }

  // Copy with method
  AppUserBrand copyWith({
    int? id,
    DateTime? createdDate,
    DateTime? modifiedDate,
    bool? isActive,
    String? headerUrl,
    String? logoUrl,
    String? brandName,
    String? slogan,
    String? targetAudience,
    String? bio,
    String? email,
    String? countryCode,
    String? phoneNumber,
  }) {
    return AppUserBrand(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      isActive: isActive ?? this.isActive,
      headerUrl: headerUrl ?? this.headerUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      brandName: brandName ?? this.brandName,
      slogan: slogan ?? this.slogan,
      targetAudience: targetAudience ?? this.targetAudience,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

//////////////////////////  User ADDRESS  MODEL  //////////////////////

class AddressModel {
  final String addressType;
  final String country;
  final String state;
  final String city;
  final String address1;
  final String address2;
  final String houseNumber;
  final int appUserId;
  final UserDataModel? appUser; // Replace with appropriate type if known
  final int id;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final bool isActive;

  AddressModel({
    required this.addressType,
    required this.country,
    required this.state,
    required this.city,
    required this.address1,
    required this.address2,
    required this.houseNumber,
    required this.appUserId,
    required this.appUser,
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
    required this.isActive,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressType: json['addressType'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      address1: json['address1'] as String,
      address2: json['address2'] as String,
      houseNumber: json['houseNumber'] as String,
      appUserId: json['appUserId'] as int,
      appUser: json['appUser'] != null
          ? UserDataModel.fromJson(json['appUser'])
          : null,
      id: json['id'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      modifiedDate: DateTime.parse(json['modifiedDate'] as String),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressType': addressType,
      'country': country,
      'state': state,
      'city': city,
      'address1': address1,
      'address2': address2,
      'houseNumber': houseNumber,
      'appUserId': appUserId,
      'appUser': appUser!.toJson(), // Replace with appropriate type if known
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}

//////////////////////////  CATEGORY  MODEL  //////////////////////

class AllCategoriesModel {
  final String name;
  final int id;
  final dynamic createdDate;
  final dynamic modifiedDate;
  final bool isActive;

  AllCategoriesModel({
    required this.name,
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
    required this.isActive,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AllCategoriesModel(
      name: json['name'] as String,
      id: json['id'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      modifiedDate: DateTime.parse(json['modifiedDate'] as String),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}


class PostModel {
  final int? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final bool? isActive;
  final String? caption;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final int? appUserId;
  final UserDataModel? appUser;
  final int? productId;
  final Product? product;
  final bool ?isLike;

  PostModel({
    this.id,
    this.createdDate,
    this.isLike,

    this.modifiedDate,
    this.isActive,
    this.caption,
    this.description,
    this.imageUrl,
    this.videoUrl,
    this.appUserId,
    this.appUser,
    this.productId,
    this.product,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int?,
      isLike:json['isLike'] as bool?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      isActive: json['isActive'] as bool?,
      caption: json['caption'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      appUserId: json['appUserId'] as int?,
      appUser: json['appUser'] != null
          ? UserDataModel.fromJson(json['appUser'])
          : null,
      productId: json['productId'] as int?,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isLike':isLike,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
      'isActive': isActive,
      'caption': caption,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'appUserId': appUserId,
      'appUser': appUser?.toJson(),
      'productId': productId,
      'product': product?.toJson(),
    };
  }
}







class AllCollectionsModel {
  final int? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final bool? isActive;
  final String? name;
  final String? imageUrl;
  final int? appUserId;
  final UserDataModel? appUser;

  AllCollectionsModel({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.isActive,
    this.name,
    this.imageUrl,
    this.appUserId,
    this.appUser,
  });

  factory AllCollectionsModel.fromJson(Map<String, dynamic> json) {
    return AllCollectionsModel(
      id: json['id'] as int?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      appUserId: json['appUserId'] as int?,
      appUser: json['appUser'] != null
          ? UserDataModel.fromJson(json['appUser'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
      'isActive': isActive,
      'name': name,
      'imageUrl': imageUrl,
      'appUserId': appUserId,
      'appUser': appUser?.toJson(),
    };
  }
}

class Product {
  String? name;
  String? weight;
  int? preparationTime;
  String? preparationUnit;
  String? info;
  int? sortOrder;
  String? imageUrl;
  int? salePrice;
  int? cost;
  String? barcode;
  List<dynamic>? productOptions;
  int? stockOnHand;
  int? stockCost;
  int? appUserId;
  UserDataModel? appUser;
  int? categoryId;
  dynamic category;
  dynamic collectionId;
  dynamic collection;
  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isActive;

  Product({
    this.name,
    this.weight,
    this.preparationTime,
    this.preparationUnit,
    this.info,
    this.sortOrder,
    this.imageUrl,
    this.salePrice,
    this.cost,
    this.barcode,
    this.productOptions,
    this.stockOnHand,
    this.stockCost,
    this.appUserId,
    this.appUser,
    this.categoryId,
    this.category,
    this.collectionId,
    this.collection,
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String?,
      weight: json['weight'] as String?,
      preparationTime: json['preparationTime'] as int?,
      preparationUnit: json['preparationUnit'] as String?,
      info: json['info'] as String?,
      sortOrder: json['sortOrder'] as int?,
      imageUrl: json['imageUrl'] as String?,
      salePrice: json['salePrice'] as int?,
      cost: json['cost'] as int?,
      barcode: json['barcode'] as String?,
      productOptions: json['productOptions'] as List<dynamic>?,
      stockOnHand: json['stockOnHand'] as int?,
      stockCost: json['stockCost'] as int?,
      appUserId: json['appUserId'] as int?,
      appUser: json['appUser']!=null?UserDataModel.fromJson(json['appUser']):null,
      categoryId: json['categoryId'] as int?,
      category: json['category'],
      collectionId: json['collectionId'],
      collection: json['collection'],
      id: json['id'] as int?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      isActive: json['isActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'preparationTime': preparationTime,
      'preparationUnit': preparationUnit,
      'info': info,
      'sortOrder': sortOrder,
      'imageUrl': imageUrl,
      'salePrice': salePrice,
      'cost': cost,
      'barcode': barcode,
      'productOptions': productOptions,
      'stockOnHand': stockOnHand,
      'stockCost': stockCost,
      'appUserId': appUserId,
      'appUser': appUser,
      'categoryId': categoryId,
      'category': category,
      'collectionId': collectionId,
      'collection': collection,
      'id': id,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
      'isActive': isActive,
    };
  }













}



class StoryModel {
  final String? text;
  final String? fileUrl;
  final int? appUserId;
  final UserDataModel? appUser;
  final int? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final bool? isActive;

  StoryModel({
    this.text,
    this.fileUrl,
    this.appUserId,
    this.appUser,
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.isActive,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      text: json['text'] as String?,
      fileUrl: json['fileUrl'] as String?,
      appUserId: json['appUserId'] as int?,
      appUser:json['appUser']!=null? UserDataModel.fromJson(json['appUser']):null,
      id: json['id'] as int?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'] as String)
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'] as String)
          : null,
      isActive: json['isActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fileUrl': fileUrl,
      'appUserId': appUserId,
      'appUser': appUser,
      'id': id,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
      'isActive': isActive,
    };
  }
}
