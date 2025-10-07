// storage_service.dart
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _savedJobsBox = 'saved_jobs_box';
  late Box<JobModel> _savedJobs;

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register JobModel adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(JobModelAdapter());
    }

    _savedJobs = await Hive.openBox<JobModel>(_savedJobsBox);
  }

  // Save job to local storage
  Future<void> saveJob(JobModel job) async {
    await _savedJobs.put(job.id, job);
  }

  // Remove job from local storage
  Future<void> removeJob(int jobId) async {
    await _savedJobs.delete(jobId);
  }

  // Check if job is saved
  bool isJobSaved(int jobId) {
    return _savedJobs.containsKey(jobId);
  }

  // Get all saved jobs
  List<JobModel> getSavedJobs() {
    return _savedJobs.values.toList();
  }

  // Stream of saved jobs for real-time updates
  Stream<BoxEvent> watchSavedJobs() {
    return _savedJobs.watch();
  }

  // Clear all saved jobs
  Future<void> clearAllSavedJobs() async {
    await _savedJobs.clear();
  }
}
