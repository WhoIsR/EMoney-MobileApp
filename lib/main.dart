import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/services/deeplink_service.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_bloc_observer.dart';
import 'firebase_options.dart';
import 'injection/injection_container.dart' as di;
import 'presentation/widgets/top_notification.dart';

// Top-level variable — mencegah DeeplinkService di-garbage collect selama
// proses berjalan sehingga uriLinkStream tetap aktif untuk in-app deeplinks.
late final DeeplinkService _deeplinkService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  // Initialize Firebase — pastikan google-services.json/GoogleService-Info.plist sudah ada
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();
  await NotificationService.instance.init();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // Simpan instance agar tidak di-GC — stream subscription harus tetap hidup
  // untuk menerima in-app deeplinks via onNewIntent (Android singleTop).
  _deeplinkService = DeeplinkService(AppRouter.router);
  await _deeplinkService.init();

  runApp(const KashiApp());
}

class KashiApp extends StatefulWidget {
  const KashiApp({super.key});

  @override
  State<KashiApp> createState() => _KashiAppState();
}

class _KashiAppState extends State<KashiApp> {
  StreamSubscription<TransactionNotificationData>? _notifSub;

  @override
  void initState() {
    super.initState();
    _notifSub = NotificationService.instance.messages.listen((data) {
      final navState = AppRouter.rootNavigatorKey.currentState;
      if (navState != null) {
        TopNotification.show(navState, title: data.title, body: data.body);
      }
    });
  }

  @override
  void dispose() {
    _notifSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kashi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
