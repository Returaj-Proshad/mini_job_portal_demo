import 'package:flutter/material.dart';
import 'package:mini_job_portal_demo/core/utils/responsive.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';
import 'package:mini_job_portal_demo/features/home/widgets/job_card.dart';

class JobListView extends StatelessWidget {
  final List<JobModel> jobs;
  final ScrollController scrollController;

  const JobListView({
    super.key,
    required this.jobs,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: context.responsive.symmetricPadding(
        vertical: 16,
        horizontal: 16,
      ),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobCard(job: job);
      },
    );
  }
}
