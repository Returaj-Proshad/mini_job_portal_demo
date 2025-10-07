import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_job_portal_demo/core/utils/app_colors.dart';
import 'package:mini_job_portal_demo/core/utils/responsive.dart';
import 'package:mini_job_portal_demo/core/utils/router.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';
import 'package:mini_job_portal_demo/features/home/widgets/details_section.dart';
import 'package:mini_job_portal_demo/features/home/widgets/overview_section.dart';
import 'package:mini_job_portal_demo/features/saved_job/state/saved_jobs_provider.dart';

class JobDetails extends ConsumerStatefulWidget {
  final JobModel job;

  const JobDetails({super.key, required this.job});

  @override
  ConsumerState<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends ConsumerState<JobDetails> {
  bool _isApplying = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  void _checkIfSaved() {
    _isSaved = ref.read(savedJobsProvider.notifier).isJobSaved(widget.job.id);
  }

  void _toggleSaveJob() {
    setState(() {
      _isSaved = !_isSaved;
    });

    if (_isSaved) {
      ref.read(savedJobsProvider.notifier).saveJob(widget.job);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.job.title} saved to your jobs'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      router.pushNamed(AppRoutes.savedJobsPage);
    } else {
      ref.read(savedJobsProvider.notifier).removeJob(widget.job.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.job.title} removed from saved jobs'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showApplyDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Apply for Job'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apply for ${widget.job.title} at ${widget.job.company}?',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your profile information will be shared with the employer.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  _submitApplication();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Apply Now'),
              ),
            ],
          ),
    );
  }

  Future<void> _submitApplication() async {
    setState(() {
      _isApplying = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isApplying = false;
    });
    _toggleSaveJob();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.errigalWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: context.responsive.scaleHeight(200),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor.withOpacity(0.8),
                      AppColors.primaryColor.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.job.company,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: _toggleSaveJob,
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  _shareJob();
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverviewSection(job: widget.job),
                  const SizedBox(height: 32),
                  _buildDescriptionSection(),
                  const SizedBox(height: 32),
                  _buildRequirementsSection(),
                  const SizedBox(height: 32),
                  DetailsSection(job: widget.job),
                  const SizedBox(height: 40),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Description',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          widget.job.description.isNotEmpty
              ? widget.job.description
              : 'We are looking for a talented ${widget.job.title} to join our team. This position offers an exciting opportunity to work on challenging projects and grow your career in a dynamic environment.',
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Requirements & Skills',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              widget.job.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isApplying ? null : _showApplyDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child:
                _isApplying
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : const Text(
                      'Apply Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        ),
      ],
    );
  }

  void _shareJob() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon!'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
