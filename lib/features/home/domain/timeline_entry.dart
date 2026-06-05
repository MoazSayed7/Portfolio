class TimelineEntry {
  const TimelineEntry({
    required this.date,
    required this.title,
    required this.description,
    this.tags = const [],
  });

  final String date;
  final String title;
  final String description;
  final List<String> tags;
}
