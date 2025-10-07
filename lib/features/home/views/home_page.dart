// home_page.dart (updated)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_job_portal_demo/core/global_widgets/error_states.dart';
import 'package:mini_job_portal_demo/core/global_widgets/loading_state.dart';
import 'package:mini_job_portal_demo/core/utils/app_colors.dart';
import 'package:mini_job_portal_demo/core/utils/router.dart';
import 'package:mini_job_portal_demo/features/home/state/home_state.dart';
import 'package:mini_job_portal_demo/features/home/widgets/job_list_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  void _navigateToProfile() {
    router.pushNamed(AppRoutes.profilePage);
  }

  @override
  Widget build(BuildContext context) {
    final jobsState = ref.watch(homeStateProvider);

    return Scaffold(
      backgroundColor: AppColors.errigalWhite,
      appBar: AppBar(
        title: const Text('Job Opportunities'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _navigateToProfile,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeStateProvider.notifier).refreshJobs(),
        child: jobsState.when(
          loading: () => const LoadingState(),
          error: (error, stack) => ErrorState(error: error.toString()),
          data:
              (jobs) =>
                  JobListView(jobs: jobs, scrollController: _scrollController),
        ),
      ),
    );
  }
}
