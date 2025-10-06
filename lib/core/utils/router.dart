import 'package:go_router/go_router.dart';
import 'package:mini_job_portal_demo/features/auth/views/login_page.dart';
import 'package:mini_job_portal_demo/features/home/views/home_page.dart';

final router = GoRouter(
  initialLocation: AppRoutes.loginPage,
  routes: [
    GoRoute(
      path: AppRoutes.loginPage,
      name: AppRoutes.loginPage,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.homePage,
      name: AppRoutes.homePage,
      builder: (context, state) => const HomePage(),
    ),
  ],
);

class AppRoutes {
  static const loginPage = '/login';
  static const homePage = '/home';
}
