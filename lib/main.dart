import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_job_portal_demo/core/services/storage_service.dart';
import 'package:mini_job_portal_demo/core/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  await Hive.openBox('userBox');
  runApp(const ProviderScope(child: JobPortalApp()));
}

class JobPortalApp extends ConsumerWidget {
  const JobPortalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(title: 'Mini Job Portal', routerConfig: router);
  }
}
