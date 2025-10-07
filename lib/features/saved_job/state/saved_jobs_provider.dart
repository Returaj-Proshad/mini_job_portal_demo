import 'package:flutter_riverpod/legacy.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';
import 'package:mini_job_portal_demo/core/services/storage_service.dart';

final savedJobsProvider =
    StateNotifierProvider<SavedJobsNotifier, List<JobModel>>((ref) {
      return SavedJobsNotifier();
    });

class SavedJobsNotifier extends StateNotifier<List<JobModel>> {
  final StorageService _storageService = StorageService();

  SavedJobsNotifier() : super([]) {
    _loadSavedJobs();
  }

  Future<void> _loadSavedJobs() async {
    final savedJobs = _storageService.getSavedJobs();
    state = savedJobs;
  }

  Future<void> saveJob(JobModel job) async {
    await _storageService.saveJob(job);
    state = _storageService.getSavedJobs();
  }

  Future<void> removeJob(int jobId) async {
    await _storageService.removeJob(jobId);
    state = _storageService.getSavedJobs();
  }

  bool isJobSaved(int jobId) {
    return _storageService.isJobSaved(jobId);
  }

  Future<void> clearAllSavedJobs() async {
    await _storageService.clearAllSavedJobs();
    state = [];
  }
}
