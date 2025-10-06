class JobModel {
  final int id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String description;
  final String type;
  final String experience;
  final List<String> skills;
  final DateTime postedDate;
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
