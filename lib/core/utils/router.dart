// routes.dart (updated)
import 'package:go_router/go_router.dart';
import 'package:mini_job_portal_demo/features/auth/views/login_page.dart';
import 'package:mini_job_portal_demo/features/home/views/home_page.dart';
import 'package:mini_job_portal_demo/features/home/views/job_details.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';

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
    GoRoute(
      path: '${AppRoutes.jobDetailsPage}/:id',
      name: AppRoutes.jobDetailsPage,
      builder: (context, state) {
        final job = state.extra as JobModel;
        return JobDetails(job: job);
      },
    ),
  ],
);

class AppRoutes {
  static const loginPage = '/login';
  static const homePage = '/home';
  static const jobDetailsPage = '/job-details';
}
