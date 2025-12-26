class WorksDto {
  final List<WorkDto> works;

  WorksDto({required this.works});

  factory WorksDto.fromJson(Map<String, dynamic> json) {
    final list = (json['works'] as List? ?? [])
        .map((e) => WorkDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return WorksDto(works: list);
  }
}

class WorkDto {
  final String title;
  final List<dynamic> authors; // list of {name: "..."} sometimes
  final int? coverId;
  final String key; // "/works/..."

  WorkDto({
    required this.title,
    required this.authors,
    required this.coverId,
    required this.key,
  });

  factory WorkDto.fromJson(Map<String, dynamic> json) {
    return WorkDto(
      title: (json['title'] as String?) ?? '-',
      authors: (json['authors'] as List?) ?? const [],
      coverId: json['cover_id'] is int ? json['cover_id'] as int : null,
      key: (json['key'] as String?) ?? '',
    );
  }

  String get authorName {
    if (authors.isEmpty) return '-';
    final first = authors.first;
    if (first is Map && first['name'] != null) return first['name'].toString();
    return first.toString();
  }
}
