import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:sera/backend/server_response.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:http/http.dart' as http;

const String pictureUrl = 'http://192.168.1.8:5052/';

class SharedWebService {
  static const String _BASE_URL = 'http://192.168.1.8:5052/api';
  final HttpClient _client = HttpClient();
  final Duration _timeoutDuration = const Duration(seconds: 60);
  static SharedWebService? _instance;
  final SharedPreferenceHelper _sharedPrefHelper =
      SharedPreferenceHelper.instance();
  // Future<LoginResponse?> get _loginResponse => _sharedPrefHelper.user;

  SharedWebService._();

  static SharedWebService instance() {
    _instance ??= SharedWebService._();
    return _instance!;
  }

  Future<HttpClientResponse> _responseFrom(
      Future<HttpClientRequest> Function(Uri) toCall,
      {required Uri uri,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    final request = await toCall(uri);
    if (headers != null) {
      headers.forEach((key, value) => request.headers.add(key, value));
    }
    if (request.method == 'POST' && body != null) {
      request.headers.contentType =
          ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8');
      request.write(Uri(queryParameters: body).query);
    }
    return request.close();
  }

  Future<HttpClientResponse> _get(Uri uri,
      [Map<String, String>? headers]) async {
    final accessToken = await _sharedPrefHelper.getAccessToken();
    final updatedHeaders = headers ?? {};
    if (accessToken != null) {
      updatedHeaders['Authorization'] = 'Bearer $accessToken';
    }
    return _responseFrom(_client.getUrl, uri: uri, headers: updatedHeaders);
  }

  Future<HttpClientResponse> _post(
    Uri uri,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    String contentType = 'application/json',
  }) async {
    final request = await _client.postUrl(uri);
    final updatedHeaders = headers ?? {};
    // Set headers
    updatedHeaders.forEach((key, value) {
      request.headers.set(key, value);
    });
    // Set content type
    if (contentType == 'application/json') {
      request.headers.contentType = ContentType.json;
      request.add(utf8.encode(json.encode(body)));
    } else if (contentType == 'application/x-www-form-urlencoded') {
      request.headers.contentType =
          ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8');
      request.add(utf8.encode(Uri(
          queryParameters: body
              .map((key, value) => MapEntry(key, value.toString()))).query));
    } else if (contentType == 'multipart/form-data') {
      var boundary = '----WebKitFormBoundary7MA4YWxkTrZu0gW';
      request.headers.set(HttpHeaders.contentTypeHeader,
          'multipart/form-data; boundary=$boundary');
      for (var entry in body.entries) {
        request.write('--$boundary\r\n');
        request.write(
            'Content-Disposition: form-data; name="${entry.key}"\r\n\r\n');
        request.write('${entry.value}\r\n');
      }
      request.write('--$boundary--\r\n');
    }

    return await request.close();
  }

  /// Login
  Future<LoginAuthenticationResponse> login(
      {String? email, String? password,
      }) async {
    final requestData = {
      'email': email,
      'password': password,
    };
    final response = await _post(
      Uri.parse('$_BASE_URL/Account/Login'),
      requestData,
    );
    final responseBody = await response.transform(utf8.decoder).join();
    log("API Response: $responseBody");
    final jsonResponse = json.decode(responseBody);
    if (jsonResponse.containsKey('token') && jsonResponse['token'] != null) {
      await SharedPreferenceHelper.instance()
          .saveAccessToken(jsonResponse['token']);
    } else {
      log("Token not found in the response");
    }
    return LoginAuthenticationResponse.fromJson(jsonResponse);
  }


  ///////////////  social login ///////////////////
  Future<LoginAuthenticationResponse> socialLogin(
      {
      String ?token,
      String ?provider,
      }) async {
    final requestData = {
      'uuId':token,
      'provider':provider,
    };
    final response = await _post(
      Uri.parse('$_BASE_URL/Account/Login'),
      requestData,
    );
    final responseBody = await response.transform(utf8.decoder).join();
    log("API Response: $responseBody");
    final jsonResponse = json.decode(responseBody);
    if (jsonResponse.containsKey('token') && jsonResponse['token'] != null) {
      await SharedPreferenceHelper.instance()
          .saveAccessToken(jsonResponse['token']);
    } else {
      log("Token not found in the response");
    }
    return LoginAuthenticationResponse.fromJson(jsonResponse);
  }

//////////////////// contact us
  Future<StatusMessageResponse> contactUs(
      {String? email, String? message, int? userId}) async {
    final accessToken = await _sharedPrefHelper.getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final requestData = {
      'email': email,
      'message': message,
      'appUserId': userId,
    };
    final response = await _post(
      Uri.parse('$_BASE_URL/Support/AddSupport'),
      requestData,
      headers: headers,
      contentType: 'application/json',
    );
    final responseBody = await response.transform(utf8.decoder).join();
    log("API Response: $responseBody");
    final jsonResponse = json.decode(responseBody);
    return StatusMessageResponse.fromJson(jsonResponse);
  }

  Future<LoginAuthenticationResponse> customerSignup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String countryCode,
  }) async {
    final requestData = {
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Password": password,
      "PhoneNumber": phoneNumber,
      "UserType": "Customer",
      'countryCode': countryCode,
    };

    final response = await _post(
      Uri.parse('$_BASE_URL/Account/SignUp'),
      requestData,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      },
      contentType: 'multipart/form-data',
    );

    final responseBody = await response.transform(utf8.decoder).join();
    log("API Response: $responseBody");

    final jsonResponse = json.decode(responseBody);

    if (response.statusCode != 200) {
      if (jsonResponse.containsKey('errors')) {
        log("Validation Errors: ${jsonResponse['errors']}");
        throw Exception("Validation Errors: ${jsonResponse['errors']}");
      }
      log("Error: ${jsonResponse['title']}");
      throw Exception("Error: ${jsonResponse['title']}");
    }

    if (jsonResponse.containsKey('token') && jsonResponse['token'] != null) {
      await SharedPreferenceHelper.instance()
          .saveAccessToken(jsonResponse['token']);
    } else {
      log("Token not found in the response");
    }

    return LoginAuthenticationResponse.fromJson(jsonResponse);
  }

  Future<LoginAuthenticationResponse> vendorSignup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String countryCode,
    String? brandLogoPath,
    required String brandName,
    required String slogan,
    required String targetAudience,
  }) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };

    final body = {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Password': password,
      'PhoneNumber': phoneNumber,
      'countryCode': countryCode,
      'UserType': 'Vendor',
      'BrandName': brandName,
      'Slogan': slogan,
      'TargetAudience': targetAudience,
    };

    final uri = Uri.parse('$_BASE_URL/Account/SignUp');
    final request = http.MultipartRequest('POST', uri);

    // Add text fields

    if (brandLogoPath != null && brandLogoPath.isNotEmpty) {
      final imageFile =
          await http.MultipartFile.fromPath('BrandLogo', brandLogoPath);
      request.files.add(imageFile);
    }

    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    log(responseData.toString());

    final finalResponse =
        LoginAuthenticationResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

  Future<AddUserAddressResponse> addAddress({
    required String country,
    required String state,
    required String city,
    required String address1,
    required String address2,
    required String houseNumber,
    required String appUserId,
    required String addressType,
  }) async {
    final requestData = {
      "country": country,
      "state": state,
      "city": city,
      "address1": address1,
      "address2": address2,
      "houseNumber": houseNumber,
      "appUserId": appUserId,
      "AddressType": addressType,
    };

    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    final response = await _post(
      Uri.parse('$_BASE_URL/Address/AddAddress'),
      requestData,
      headers: headers,
      contentType: 'application/json',
    );

    final responseBody = await response.transform(utf8.decoder).join();
    log("API Response: $responseBody");

    final jsonResponse = json.decode(responseBody);

    return AddUserAddressResponse.fromJson(jsonResponse);
  }

/////////////////////  UPDATE  PROFILE

  /// Edit Profile
  Future<UpdateProfileResponse> updateProfile(
    String id,
    String firstName,
    String lastName,
    String phoneCode,
    String phone,
    String email,
    String image,
  ) async {
    final accessToken = await _sharedPrefHelper.getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final body = {
      'id': id,
      if (firstName.isNotEmpty) 'FirstName': firstName,
      if (lastName.isNotEmpty) 'LastName': lastName,
      if (email.isNotEmpty) 'Email': email,
      if (phone.isNotEmpty) 'PhoneNumber': phone,
      if (phoneCode.isNotEmpty) 'CountryCode': phoneCode,
    };
    final uri = Uri.parse('$_BASE_URL/Account/UpdateProfile');
    final request = http.MultipartRequest('POST', uri);
    if (image.isNotEmpty) {
      final imageFile = await http.MultipartFile.fromPath('Image', image);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    log(responseData.toString());
    final finalResponse =
        UpdateProfileResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

  /// Edit Brand
  Future<UpdateBrandResponse> updateBrand(
      String id,
      String brandName,
      String bio,
      String phoneCode,
      String phone,
      String email,
      String headerImage,
      String logoImage) async {
    final accessToken = await _sharedPrefHelper.getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final body = {
      'Id': id,
      if (brandName.isNotEmpty) 'BrandName': brandName,
      if (bio.isNotEmpty) 'Bio': bio,
      if (email.isNotEmpty) 'Email': email,
      if (phone.isNotEmpty) 'PhoneNumber': phone,
      if (phoneCode.isNotEmpty) 'CountryCode': phoneCode,
    };
    final uri = Uri.parse('$_BASE_URL/Account/UpdateBrand');
    final request = http.MultipartRequest('POST', uri);
    if (logoImage.isNotEmpty) {
      final imageFile =
          await http.MultipartFile.fromPath('LogoImage', logoImage);
      request.files.add(imageFile);
    }
    if (headerImage.isNotEmpty) {
      final imageFile =
          await http.MultipartFile.fromPath('HeaderImage', headerImage);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    log("RRRRRRRRRRRRRRRRRRRRRRRRR$responseData");
    final finalResponse =
        UpdateBrandResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

///////// Add New Collection
  Future<IBaseResponse> addNewCollection({
    required String name,
    required int appUserId,
    String? imagePath,
  }) async {
    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final body = {
      'Name': name,
      'AppUserId': appUserId.toString(),
    };
    final uri = Uri.parse('$_BASE_URL/Collection/AddCollection');
    final request = http.MultipartRequest('POST', uri);
    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile = await http.MultipartFile.fromPath('Image', imagePath);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    final finalResponse =
        StatusMessageResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

  Future<GetAllCollectionsMethod> getCollections({id = 0}) async {
    final response = await _get(
        Uri.parse('$_BASE_URL/Collection/GetAllCollections?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());

    return GetAllCollectionsMethod.fromJson(json.decode(responseBody));
  }

  Future<AddUserAddressResponse> getAddress({id = 0}) async {
    final response =
        await _get(Uri.parse('$_BASE_URL/Address/GetAllAddresss?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());

    return AddUserAddressResponse.fromJson(json.decode(responseBody));
  }

  Future<AllVendorsData> allVendors({id = 0}) async {
    final response = await _get(Uri.parse('$_BASE_URL/Vendor/GetAllVendors'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return AllVendorsData.fromJson(json.decode(responseBody));
  }

  ///////// ADD NEW PRODUCT
  Future<LoginAuthenticationResponse> addProduct({
    required String name,
    required String catergoryId,
    required String weight,
    required String preparationTime,
    required String preparationUnit,
    String info = '',
    required String sortorder,
    required String salePrice,
    required String cost,
    String barcode = '',
    required String userId,
    required String collectionId,
    required String stockOnHand,
    required String stockCost,
    required String image,
    required String options,
  }) async {
    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    log(options);

    final body = {
      'Name': name,
      'CategoryId': catergoryId,
      'Weight': weight,
      'PreparationTime': preparationTime,
      'PreparationUnit': preparationUnit,
      'Info': info,
      'SortOrder': sortorder,
      'SalePrice': salePrice,
      'Cost': cost,
      'Barcode': barcode,
      'AppUserId': userId,
      if (collectionId.isNotEmpty) 'CollectionId': collectionId,
      'StockOnHand': stockOnHand,
      'StockCost': stockCost,
      'ProductOptions': options
    };
    final uri = Uri.parse('$_BASE_URL/Product/AddProduct');
    final request = http.MultipartRequest('POST', uri);
    // Add text fields
    if (image.isNotEmpty) {
      final imageFile = await http.MultipartFile.fromPath('Image', image);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    // log(responseData.toString());

    final finalResponse =
        LoginAuthenticationResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

///////// Add New Collection
  Future<IBaseResponse> addNewPost({
    required int appUserId,
    required int productId,
    String? imagePath,
    String? videoPath,
    String? description,
  }) async {
    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final body = {
      'description': description.toString(),
      'appUserId': appUserId.toString(),
    };

    final uri = Uri.parse('$_BASE_URL/Collection/AddCollection');
    final request = http.MultipartRequest('POST', uri);
    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile =
          await http.MultipartFile.fromPath('imageUrl', imagePath);
      request.files.add(imageFile);
    }
    if (videoPath != null && videoPath.isNotEmpty) {
      final imageFile =
          await http.MultipartFile.fromPath('videoUrl', videoPath);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final finalResponse =
        StatusMessageResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

///////// GetAllPost
  Future<AllPostsData> getAllPost() async {
    final response = await _get(Uri.parse('$_BASE_URL/Post/GetAllPosts'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return AllPostsData.fromJson(json.decode(responseBody));
  }

  //////// GetAllPostbyuserid
  Future<AllPostsData> getAllPostByUserId({id = 0}) async {
    final response =
        await _get(Uri.parse('$_BASE_URL/Post/GetAllPosts?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    log(responseBody.toString());
    return AllPostsData.fromJson(json.decode(responseBody));
  }

  //////// GetAllProductbyUserId
  Future<GetAllProduct> getAllProductsByUserId({id = 0}) async {
    final response =
        await _get(Uri.parse('$_BASE_URL/Product/GetAllProducts?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return GetAllProduct.fromJson(json.decode(responseBody));
  }

  //////// GetAllCategory
  Future<AllCategory> getAllCategory({id = 11}) async {
    final response = await _get(
        Uri.parse('$_BASE_URL/Category/GetAllCategories?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return AllCategory.fromJson(json.decode(responseBody));
  }

  //////// GetAllProduct
  Future<GetAllProduct> getAllProducts() async {
    final response = await _get(Uri.parse('$_BASE_URL/Product/GetAllProducts'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return GetAllProduct.fromJson(json.decode(responseBody));
  }

  ///////// GetAllProductByUserId
  Future<AllCategory> getProductByUserId({id = 0}) async {
    final response = await _get(
        Uri.parse('$_BASE_URL/Product/GetProductsByUserId?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return AllCategory.fromJson(json.decode(responseBody));
  }

  ///////// GetAllProductByCategory
  Future<GetAllProduct> getAllProductByCategory({id = 0}) async {
    final response = await _get(
        Uri.parse('$_BASE_URL/Product/GetProductsByCategoryId?categoryId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    // log(responseBody.toString());
    return GetAllProduct.fromJson(json.decode(responseBody));
  }


  ///////// GetAllProductByCategory

  Future<ProductDetailResponse> getProductById({id = 0}) async {
    final response = await _get(
        Uri.parse('$_BASE_URL/Product/GetProductById?Id=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    log(responseBody.toString());
    return ProductDetailResponse.fromJson(json.decode(responseBody));
  }


  ///////// GetAllProductByUserId
  Future<GetAllProduct> getlikeProducts({id = 0}) async {
    final response =
        await _get(Uri.parse('$_BASE_URL/Product/GetProductById?Id=3$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    log(responseBody.toString());
    return GetAllProduct.fromJson(json.decode(responseBody));
  }

  Future<IBaseResponse> likeProduct(userId, productId, bool isfav) async {
    final body = {
      "productId": productId,
      "isLike": isfav,
      "appUserId": userId,
    };
    final response =
        await _post(Uri.parse('$_BASE_URL/Product/LikeProduct'), body);
    final responseBody = await response.transform(utf8.decoder).join();
    // log('-----> $responseBody');
    return StatusMessageResponse.fromJson(json.decode(responseBody));
  }

///////// Add New Post
  Future<IBaseResponse> addPost({
    String caption = '',
    required int appUserId,
    required int productId,
    String? imagePath,
    String? videoPath,
  }) async {
    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    // log(caption);
    // log(appUserId.toString());
    // log(productId.toString());
    // log(videoPath.toString());

    final body = {
      'Caption': caption,
      'AppUserId': appUserId.toString(),
      'ProductId': productId.toString(),
    };
    final uri = Uri.parse('$_BASE_URL/Post/AddPost');
    final request = http.MultipartRequest('POST', uri);
    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile = await http.MultipartFile.fromPath('Image', imagePath);
      request.files.add(imageFile);
    }
    if (videoPath != null && videoPath.isNotEmpty) {
      final videoFile = await http.MultipartFile.fromPath('Video', videoPath);
      request.files.add(videoFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    log(responseData.toString());
    final finalResponse =
        StatusMessageResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }

///////// Add New Post
  Future<IBaseResponse> addStory({
    required int appUserId,
    String? filePath,
    String caption = '',
  }) async {
    final accessToken =
        await SharedPreferenceHelper.instance().getAccessToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final body = {
      'AppUserId': appUserId.toString(),
      'Text': caption.isNotEmpty ? caption : "",
    };
    final uri = Uri.parse('$_BASE_URL/Story/AddStory');
    final request = http.MultipartRequest('POST', uri);
    if (filePath != null && filePath.isNotEmpty) {
      final imageFile = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(imageFile);
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    log(responseData.toString());
    final finalResponse =
        StatusMessageResponse.fromJson(json.decode(responseData));
    return finalResponse;
  }



  ///////// GetAllProductByUserId
  Future<GetAllStories> getAllStories({id = 0}) async {
    final response =
        await _get(Uri.parse('$_BASE_URL/Story/GetAllStories?userId=$id'));
    final responseBody = await response.transform(utf8.decoder).join();
    log(responseBody.toString());
    return GetAllStories.fromJson(json.decode(responseBody));
  }

 







}
