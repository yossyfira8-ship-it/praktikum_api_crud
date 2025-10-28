class CreatedUser {
  final String name;
  final String job;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CreatedUser({
    required this.name,
    required this.job,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CreatedUser.fromJson(Map<String, dynamic> json) {
    DateTime? _tryParse(String? s) => s == null ? null : DateTime.tryParse(s);
    return CreatedUser(
      name: json['name'] as String? ?? '',
      job: json['job'] as String? ?? '',
      id: json['id'] as String?,
      createdAt: _tryParse(json['createdAt'] as String?),
      updatedAt: _tryParse(json['updatedAt'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
      if (id != null) 'id': id,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}