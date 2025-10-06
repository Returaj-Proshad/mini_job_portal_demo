import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mini_job_portal_demo/features/home/apis/home_page_apis.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';

final homeStateProvider =
    StateNotifierProvider<HomeState, AsyncValue<List<JobModel>>>(
      (ref) => HomeState(),
    );

class HomeState extends StateNotifier<AsyncValue<List<JobModel>>> {
  HomeState() : super(const AsyncValue.loading()) {
    loadJobs();
  }

  final HomePageApis _apiService = HomePageApis.instance;

  Future<void> loadJobs() async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiService.getJobs(limit: 20);
      state = AsyncValue.data(response.jobs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshJobs() async {
    try {
      final response = await _apiService.getJobs(limit: 20);
      state = AsyncValue.data(response.jobs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
