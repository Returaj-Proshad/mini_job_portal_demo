// routes.dart (updated)
import 'package:go_router/go_router.dart';
import 'package:mini_job_portal_demo/features/auth/views/login_page.dart';
import 'package:mini_job_portal_demo/features/home/views/home_page.dart';
import 'package:mini_job_portal_demo/features/home/views/job_details.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';
import 'package:mini_job_portal_demo/features/home/views/profile_page.dart';
import 'package:mini_job_portal_demo/features/saved_job/view/saved_jobs_page.dart';
import 'package:mini_job_portal_demo/features/splash_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
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

    GoRoute(
      path: AppRoutes.savedJobsPage,
      name: AppRoutes.savedJobsPage,
      builder: (context, state) => const SavedJobsPage(),
    ),
    GoRoute(
      path: AppRoutes.profilePage,
      name: AppRoutes.profilePage,
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);

class AppRoutes {
  static const splashScreen = '/';
  static const loginPage = '/login';
  static const homePage = '/home';
  static const jobDetailsPage = '/job-details';
  static const savedJobsPage = '/saved-jobs-page';
  static const profilePage = '/profile';
}
