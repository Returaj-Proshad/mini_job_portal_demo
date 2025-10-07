// saved_jobs_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_job_portal_demo/core/utils/app_colors.dart';
import 'package:mini_job_portal_demo/core/utils/responsive.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';
import 'package:mini_job_portal_demo/features/home/widgets/job_card.dart';
import 'package:mini_job_portal_demo/features/saved_job/state/saved_jobs_provider.dart';

class SavedJobsPage extends ConsumerStatefulWidget {
  const SavedJobsPage({super.key});

  @override
  ConsumerState<SavedJobsPage> createState() => _SavedJobsPageState();
}

class _SavedJobsPageState extends ConsumerState<SavedJobsPage> {
  @override
  Widget build(BuildContext context) {
    final savedJobs = ref.watch(savedJobsProvider);

    return Scaffold(
      backgroundColor: AppColors.errigalWhite,
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          if (savedJobs.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _showClearAllDialog,
            ),
        ],
      ),
      body:
          savedJobs.isEmpty
              ? _buildEmptyState()
              : _buildSavedJobsList(savedJobs),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              'No Saved Jobs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Save jobs you\'re interested in by tapping the bookmark icon on job details.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Browse Jobs'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedJobsList(List<JobModel> savedJobs) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.bookmark, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                '${savedJobs.length} ${savedJobs.length == 1 ? 'Job' : 'Jobs'} Saved',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: context.responsive.symmetricPadding(
              vertical: 8,
              horizontal: 16,
            ),
            itemCount: savedJobs.length,
            itemBuilder: (context, index) {
              final job = savedJobs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _SavedJobCard(job: job),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Clear All Saved Jobs'),
            content: const Text(
              'Are you sure you want to remove all saved jobs? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(savedJobsProvider.notifier).clearAllSavedJobs();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All saved jobs have been removed'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear All'),
              ),
            ],
          ),
    );
  }
}

class _SavedJobCard extends ConsumerWidget {
  final JobModel job;

  const _SavedJobCard({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key('saved_job_${job.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmation(context);
      },
      onDismissed: (direction) {
        ref.read(savedJobsProvider.notifier).removeJob(job.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${job.title} removed from saved jobs'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {
                ref.read(savedJobsProvider.notifier).saveJob(job);
              },
            ),
          ),
        );
      },
      child: JobCard(job: job),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Remove Saved Job'),
            content: Text('Remove ${job.title} from saved jobs?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Remove'),
              ),
            ],
          ),
    );
    return result ?? false;
  }
}
