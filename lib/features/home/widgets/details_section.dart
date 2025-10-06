import 'package:flutter/material.dart';
import 'package:mini_job_portal_demo/core/utils/functions.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';

class DetailsSection extends StatelessWidget {
  final JobModel job;
  const DetailsSection({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Job Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.business_center,
            title: 'Company',
            value: job.company,
          ),
          _buildDetailRow(
            icon: Icons.location_on,
            title: 'Location',
            value: job.location,
          ),
          _buildDetailRow(icon: Icons.work, title: 'Job Type', value: job.type),
          _buildDetailRow(
            icon: Icons.timeline,
            title: 'Experience',
            value: job.experience,
          ),
          if (job.isRemote)
            _buildDetailRow(
              icon: Icons.work_outline,
              title: 'Work Mode',
              value: 'Remote',
            ),
          _buildDetailRow(
            icon: Icons.calendar_today,
            title: 'Posted',
            value: getTimeAgo(job.postedDate),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
