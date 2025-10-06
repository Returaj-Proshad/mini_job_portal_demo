import 'package:mini_job_portal_demo/core/services/api_service.dart';
import 'package:mini_job_portal_demo/features/home/models/job_model.dart';

class JobListResponse {
  final List<JobModel> jobs;
  final int total;
  final int skip;
  final int limit;

  JobListResponse({
    required this.jobs,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory JobListResponse.fromJson(Map<String, dynamic> json) {
    return JobListResponse(
      jobs: List<JobModel>.from(
        (json['products'] ?? []).map((x) => JobModel.fromJson(x)),
      ),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class HomePageApis {
  static HomePageApis instance = HomePageApis._();
  HomePageApis._();

  final ApiService _apiService = ApiService();

  Future<JobListResponse> getJobs({int limit = 10, int skip = 0}) async {
    try {
      final response = await _apiService.get(
        '/products',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      // Since dummyjson returns products, we'll map them to job-like data
      final data = response.data as Map<String, dynamic>;
      final products = data['products'] as List;

      // Convert products to jobs with job-like data
      final jobs =
          products.map((product) {
            final productMap = product as Map<String, dynamic>;
            return JobModel(
              id: productMap['id'] ?? 0,
              title: productMap['title'] ?? 'Job Position',
              company: _getRandomCompany(),
              location: _getRandomLocation(),
              salary: _getRandomSalary(),
              description:
                  productMap['description'] ?? 'Job description not available',
              type: _getRandomJobType(),
              experience: _getRandomExperience(),
              skills: _getRandomSkills(),
              postedDate: DateTime.now().subtract(
                Duration(days: (productMap['id'] ?? 0) * 2),
              ),
              isRemote: (productMap['id'] ?? 0) % 3 == 0,
            );
          }).toList();

      return JobListResponse(
        jobs: jobs,
        total: data['total'] ?? 0,
        skip: data['skip'] ?? 0,
        limit: data['limit'] ?? 0,
      );
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }

  String _getRandomCompany() {
    final companies = [
      'TechCorp Inc.',
      'Innovate Labs',
      'Digital Solutions',
      'Future Systems',
      'Cloud Ventures',
      'Data Analytics Co.',
      'Mobile First',
      'Web Services Ltd.',
      'AI Innovations',
    ];
    return companies[(DateTime.now().millisecond % companies.length)];
  }

  String _getRandomLocation() {
    final locations = [
      'Seoul, South Korea',
      'New York, USA',
      'London, UK',
      'Tokyo, Japan',
      'Berlin, Germany',
      'Sydney, Australia',
      'Toronto, Canada',
      'Singapore',
      'Paris, France',
    ];
    return locations[(DateTime.now().millisecond % locations.length)];
  }

  String _getRandomSalary() {
    final salaries = [
      '৳50,000 - ৳70,000',
      '৳60,000 - ৳80,000',
      '৳70,000 - ৳90,000',
      '৳80,000 - ৳100,000',
      '৳90,000 - ৳110,000',
      '৳100,000 - ৳130,000',
    ];
    return salaries[(DateTime.now().millisecond % salaries.length)];
  }

  String _getRandomJobType() {
    final types = ['Full-time', 'Part-time', 'Contract', 'Internship'];
    return types[(DateTime.now().millisecond % types.length)];
  }

  String _getRandomExperience() {
    final experiences = [
      'Entry Level',
      'Mid Level',
      'Senior Level',
      'Executive',
    ];
    return experiences[(DateTime.now().millisecond % experiences.length)];
  }

  List<String> _getRandomSkills() {
    final allSkills = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST API',
      'Git',
      'CI/CD',
      'UI/UX',
      'MongoDB',
      'Node.js',
      'Python',
      'AWS',
      'Docker',
    ];
    return allSkills.sublist(0, 3 + (DateTime.now().millisecond % 3));
  }
}
