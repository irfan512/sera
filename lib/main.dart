import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sera/firebase_options.dart';
import 'package:sera/helper/notification_helper.dart';
import 'package:sera/ui/Liked_products/liked_products.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_bloc.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_screen.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_screen.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen_bloc.dart';
import 'package:sera/ui/add_story_post/story/story_bloc.dart';
import 'package:sera/ui/add_story_post/story/story_screen.dart';
import 'package:sera/ui/addressess/addressess_bloc.dart';
import 'package:sera/ui/addressess/addressess_screen.dart';
import 'package:sera/ui/auth/add_address/add_address_bloc.dart';
import 'package:sera/ui/auth/add_address/add_address_screen.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_bloc.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_screen.dart';
import 'package:sera/ui/auth/login/login_screen.dart';
import 'package:sera/ui/auth/login/login_screen_bloc.dart';
import 'package:sera/ui/auth/signup/signup_main_screen.dart';
import 'package:sera/ui/auth/signup/signup_screen_bloc.dart';
import 'package:sera/ui/business_update%20/brand_edit_bloc.dart';
import 'package:sera/ui/business_update%20/business_update_screen.dart';
import 'package:sera/ui/cart/cart_bloc.dart';
import 'package:sera/ui/cart/cart_screen.dart';
import 'package:sera/ui/cart_checkout/cart_checkout.dart';
import 'package:sera/ui/cart_checkout/cart_checkout_bloc.dart';
import 'package:sera/ui/contact_us/contact_us.dart';
import 'package:sera/ui/contact_us/contact_us_bloc.dart';
import 'package:sera/ui/edit_profile/edit_profile_bloc.dart';
import 'package:sera/ui/edit_profile/edit_profile_screen.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_screen.dart';
import 'package:sera/ui/messages/messages_screen.dart';
import 'package:sera/ui/messages/nessage_list.dart';
import 'package:sera/ui/notifications/notification_bloc.dart';
import 'package:sera/ui/notifications/notification_screen.dart';
import 'package:sera/ui/orders/orders_bloc.dart';
import 'package:sera/ui/orders/orders_screen.dart';
import 'package:sera/ui/payment/k-net.dart';
import 'package:sera/ui/product_detail/product_detail_bloc.dart';
import 'package:sera/ui/product_detail/product_detail_screen.dart';
import 'package:sera/ui/profile/profile_screen.dart';
import 'package:sera/ui/profile/profile_screen_bloc.dart';
import 'package:sera/ui/splash_screen.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';
import 'package:sera/util/dark_theme_constant.dart';
import 'package:sera/util/light_theme_constant.dart';
import 'helper/shared_preference_helper.dart';

final BaseConstant darkThemeConstant = DarkThemeConstant();
final BaseConstant lightThemeConstant = LightThemeConstant();

class PlaceDetailsArguments {
  final int placeData;
  final double lat;
  final double long;

  PlaceDetailsArguments({
    required this.placeData,
    required this.lat,
    required this.long,
  });
}

class _AppRouter {
  PageRoute _getPageRoute(Widget widget) => Platform.isIOS
      ? CupertinoPageRoute(builder: (_) => widget)
      : MaterialPageRoute(builder: (_) => widget);

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        {
          const screen = SplashScreen();
          return _getPageRoute(screen);
        }
      case LoginScreen.route:
        {
          var screen = LoginScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => LoginScreenBloc(), child: screen));
        }
      case ChooseScreen.route:
        {
          const screen = ChooseScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => ChooseScreenBloc(), child: screen));
        }
      case SignupMainScreen.route:
        {
          final value = settings.arguments as String;
          var screen = SignupMainScreen(usertype: value);
          return _getPageRoute(
              BlocProvider(create: (_) => SignupScreenBloc(), child: screen));
        }
      case PersonalProfileScreen.route:
        {
          var screen = const PersonalProfileScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => ProfileScreenBloc(), child: screen));
        }
      case AddAddress.route:
        {
          final data = settings.arguments as bool;
          var screen = AddAddress(
            iseditScreen: data,
          );
          return _getPageRoute(BlocProvider(
              create: (_) => NewAddressScreenBloc(), child: screen));
        }
      case MainScreen.route:
        {
          const screen = MainScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => MainScreenBloc(), child: screen));
        }
      case ProductDetail.route:
        {
          final id = settings.arguments as int;
          var screen = ProductDetail(
            productId: id,
          );
          return _getPageRoute(
              BlocProvider(create: (_) => ProductDetailBloc(), child: screen));
        }
      case EditProfile.route:
        {
          const screen = EditProfile();
          return _getPageRoute(
              BlocProvider(create: (_) => EditProfileBloc(), child: screen));
        }
      case ContactUs.route:
        {
          const screen = ContactUs();
          return _getPageRoute(
              BlocProvider(create: (_) => ContactUsBloc(), child: screen));
        }
      case NotificationScreen.route:
        {
          var screen = NotificationScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => NotificationBloc(), child: screen));
        }

      case AddressScreen.route:
        {
          var screen = const AddressScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => AddressessBloc(), child: screen));
        }
      case CartScreen.route:
        {
          var screen = const CartScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => CartScreenBloc(), child: screen));
        }

      case CartCheckout.route:
        {
          var screen =  CartCheckout();
          return _getPageRoute(
              BlocProvider(create: (_) => CartCheckoutBloc(), child: screen));
        }
      case OrderScreen.route:
        {
          var screen = const OrderScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => OrdersBloc(), child: screen));
        }
      case MessagesScreen.route:
        {
          const screen = MessagesScreen();
          return _getPageRoute(screen);
        }
      case LikedProducts.route:
        {
          const screen = LikedProducts();
          return _getPageRoute(screen);
        }
      case KNET.route:
        {
          var screen = KNET();
          return _getPageRoute(screen);
        }

      case UserMessagesScreen.route:
        {
          var screen = UserMessagesScreen();
          return _getPageRoute(screen);
        }
      case EditBrand.route:
        {
          var screen = const EditBrand();
          return _getPageRoute(
              BlocProvider(create: (_) => EditBrandBloc(), child: screen));
        }
      case AddCollection.route:
        {
          var screen = const AddCollection();
          return _getPageRoute(
              BlocProvider(create: (_) => AddCollectionBloc(), child: screen));
        }
      case AddProductScreen.route:
        {
          var screen = const AddProductScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => AddProductBloc(), child: screen));
        }
      case AddStoryPostScreen.route:
        {
          var screen = const AddStoryPostScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => AddStoryPostBloc(), child: screen));
        }
      case AddStoryScreen.route:
        {
          var screen = const AddStoryScreen();
          return _getPageRoute(
              BlocProvider(create: (_) => AddStoryBloc(), child: screen));
        }
    }
    return null;
  }
}

class _AppState extends StatelessWidget {
  const _AppState();

  @override
  Widget build(BuildContext context) {
    final router = _AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddProductBloc>(
          create: (context) => AddProductBloc(),
        ),
        BlocProvider<AddStoryPostBloc>(
          create: (context) => AddStoryPostBloc(),
        ),
         BlocProvider<AddStoryBloc>(
          create: (context) => AddStoryBloc(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: router.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          title: AppStrings.APP_NAME,
          darkTheme: darkThemeConstant.themeData,
          theme: lightThemeConstant.themeData),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.initializeSharedPreferences();
  Stripe.publishableKey = 'pk_test_afwN0Kwq5lY8LR7PKMlGNeLW';
  await dotenv.load(fileName: "assets/.env");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   NotificationHelper.instance().initializeAppNotifications();
  runApp(const _AppState());
}

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   // Handle the in-app notification directly here
  //   if (message.notification != null) {
  //     // Display an in-app notification
  //     AndroidNotificationDetails androidPlatformChannelSpecifics =
  //         const AndroidNotificationDetails(
  //       'your_channel_id',
  //       'your_channel_name',
  //       importance: Importance.defaultImportance,
  //       enableLights: true,
  //       visibility: NotificationVisibility.public,
  //     );

  //     final NotificationDetails platformChannelSpecifics =
  //         NotificationDetails(android: androidPlatformChannelSpecifics);
  //     final Map<String, DarwinNotificationDetails>
  //         iosNotificationDetailsWithChannelName = {};
  //     final darwinNotificationDetails =
  //         iosNotificationDetailsWithChannelName[''];
  //     if (Platform.isIOS && darwinNotificationDetails == null) return;

  //     FlutterLocalNotificationsPlugin().show(
  //       0,
  //       message.notification?.title ?? '',
  //       message.notification?.body ?? '',
  //       platformChannelSpecifics,
  //       payload: message.data['data'],
  //     );
  //   }
  // });


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   // Display an in-app notification
//   if (message.notification != null) {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.defaultImportance,
//       enableLights: true,
//       visibility: NotificationVisibility.public,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     final Map<String, DarwinNotificationDetails>
//         iosNotificationDetailsWithChannelName = {};
//     final darwinNotificationDetails = iosNotificationDetailsWithChannelName[''];
//     if (Platform.isIOS && darwinNotificationDetails == null) return;

//     await FlutterLocalNotificationsPlugin().show(
//       0,
//       message.notification?.title ?? '',
//       message.notification?.body ?? '',
//       platformChannelSpecifics,
//       payload: message.data['data'],
//     );
//   }
// }




class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notification = event.notification;
  print('//////////////============Notification \n$notification============/////////////');
}