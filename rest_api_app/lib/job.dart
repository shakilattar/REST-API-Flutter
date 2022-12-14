class Job {
  Job({this.id, this.position, this.company, this.description});

  final int? id;
  final String? position;
  final String? company;
  final String? description;

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      position: json['position'],
      company: json['company'],
      description: json['description'],
    );
  }
}
