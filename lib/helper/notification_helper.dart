import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(NotificationResponse notificationResponse) async {
  final payload = notificationResponse.payload ?? '';
  if (payload.isEmpty) return;

  final Map<String, dynamic> notificationData = jsonDecode(payload);
  notificationData['action_id'] = notificationResponse.actionId;
  await _saveNotificationPayload(notificationData);
}

Future<void> _saveNotificationPayload(Map<String, dynamic> notificationData) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.reload();
  sharedPreferences.setString('SharedPreferenceHelper.current_notification_payload', jsonEncode(notificationData));
}

class NotificationHelper {
  static NotificationHelper? _instance;
  static const String CHAT_NOTIFICATION_TITLE = 'Chat Notification Channel';

  static const String _CHAT_NOTIFICATION_CHANNEL = 'com.triaxo.toggle-in_chat_notification_channel';

  final _random = Random(1);
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings _darwinInitializationSettings =
      DarwinInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) {}, requestCriticalPermission: true, notificationCategories: [
    const DarwinNotificationCategory('com.triaxo.toggle-in_darwin_notification_category_chat'),
  ]);

  cancelNotification() {
    _flutterLocalNotificationPlugin.cancelAll();
  }

  // final Map<String, AndroidNotificationDetails> _androidNotificationDetailsWithChannelName = {
  //   CHAT_NOTIFICATION_TITLE: const AndroidNotificationDetails(
  //     _CHAT_NOTIFICATION_CHANNEL,
  //     CHAT_NOTIFICATION_TITLE,
  //     importance: Importance.defaultImportance,
  //     enableLights: true,
  //     visibility: NotificationVisibility.public,
  //   )
  // };
  //
  // final Map<String, DarwinNotificationDetails> _iosNotificationDetailsWithChannelName = {
  //   CHAT_NOTIFICATION_TITLE: const DarwinNotificationDetails(
  //       presentAlert: true,
  //       presentSound: true,
  //       categoryIdentifier: 'com.triaxo.toggle-in_darwin_notification_category_chat_1',
  //       interruptionLevel: InterruptionLevel.timeSensitive)
  // };

  InitializationSettings get _initializationSettings => InitializationSettings(android: _androidInitializationSetting, iOS: _darwinInitializationSettings);

  NotificationHelper._internal();

  static NotificationHelper instance() {
    _instance ??= NotificationHelper._internal();
    return _instance!;
  }

  void initializeAppNotifications() => _flutterLocalNotificationPlugin.initialize(_initializationSettings, onDidReceiveNotificationResponse: (notificationResponse) async {
        final payload = notificationResponse.payload ?? '';
        if (payload.isEmpty) return;
        final Map<String, dynamic> notificationData = jsonDecode(payload);
        // await _saveNotificationPayload(notificationData);
      }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  int get _randomNumber => int.parse(List.generate(6, (_) => _random.nextInt(9)).join());

  Future<String?> getLastPayload() async {
    final notificationDetails = await _flutterLocalNotificationPlugin.getNotificationAppLaunchDetails();
    print('notificaton detail ------------->');
    return notificationDetails?.notificationResponse?.payload;
  }

  // Future<void> showNotification(
  //     {required String title,
  //     required String content,
  //     String route = '',
  //     Map<String, dynamic>? arguments,
  //     String? payload}) async {
  //   // if (!isPluginInitialize) {
  //   await _flutterLocalNotificationPlugin.initialize(_initializationSettings, onDidReceiveNotificationResponse: (s) {
  //     print('==================>>route $s');
  //     if (route.isNotEmpty) Get.toNamed(route, arguments: arguments);
  //   });
  //   // if (route.isNotEmpty) isPluginInitialize = true;
  //   // }
  //   // _flutterLocalNotificationPlugin.show(_randomNumber, title, content, _notificationDetails, payload: payload);
  // }

  Future<void> showNotificationV2(String title, String content, {String? payload}) async {
    const androidNotificationDetails = AndroidNotificationDetails(_CHAT_NOTIFICATION_CHANNEL, CHAT_NOTIFICATION_TITLE,
        importance: Importance.max, enableLights: true, visibility: NotificationVisibility.public, priority: Priority.defaultPriority, enableVibration: true, playSound: true);

    const darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true, presentSound: true, categoryIdentifier: 'com.triaxo.toggle-in_darwin_notification_category_chat_1', interruptionLevel: InterruptionLevel.timeSensitive);

    const notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);
    _flutterLocalNotificationPlugin.show(_randomNumber, title, content, notificationDetails, payload: payload);
  }

  Future<bool?> get requestAppNotification async => Platform.isIOS
      ? _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true)
      : _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  Future<NotificationAppLaunchDetails?> get activeNotificationResponse => _flutterLocalNotificationPlugin.getNotificationAppLaunchDetails();
}