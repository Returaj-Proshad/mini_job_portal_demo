// job_model.dart
import 'package:hive/hive.dart';

part 'job_model.g.dart';

@HiveType(typeId: 0)
class JobModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String company;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String salary;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String type;

  @HiveField(7)
  final String experience;

  @HiveField(8)
  final List<String> skills;

  @HiveField(9)
  final DateTime postedDate;

  @HiveField(10)
  final bool isRemote;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.description,
    required this.type,
    required this.experience,
    required this.skills,
    required this.postedDate,
    required this.isRemote,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      company: json['company'] ?? 'Unknown Company',
      location: json['location'] ?? 'Remote',
      salary: json['salary'] ?? 'Not specified',
      description: json['description'] ?? '',
      type: json['type'] ?? 'Full-time',
      experience: json['experience'] ?? 'Not specified',
      skills: List<String>.from(json['skills'] ?? []),
      postedDate: DateTime.parse(
        json['postedDate'] ?? DateTime.now().toString(),
      ),
      isRemote: json['isRemote'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'salary': salary,
      'description': description,
      'type': type,
      'experience': experience,
      'skills': skills,
      'postedDate': postedDate.toIso8601String(),
      'isRemote': isRemote,
    };
  }
}
