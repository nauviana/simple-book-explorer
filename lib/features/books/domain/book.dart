class Book {
  final String title;
  final String author;
  final int? coverId;
  final String workKey; // contoh: "/works/OL12345W"

  const Book({
    required this.title,
    required this.author,
    required this.workKey,
    required this.coverId,
  });

  String get coverUrl =>
      coverId == null ? '' : 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';
}
