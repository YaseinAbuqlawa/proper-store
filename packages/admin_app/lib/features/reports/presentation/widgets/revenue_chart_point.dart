/// One point on a revenue bar chart, carrying its rendered x-axis [label]
/// and the raw [tooltipKey] used for tooltips + refund lookups.
class RevenueChartPoint {
  final String label;
  final String tooltipKey;
  final double value;

  const RevenueChartPoint({
    required this.label,
    required this.tooltipKey,
    required this.value,
  });

  /// Daily revenue entries → points. Shows every 5th day as the x-axis label,
  /// blank otherwise; tooltip uses the full `yyyy-MM-dd` key.
  static List<RevenueChartPoint> daily(
    List<MapEntry<String, double>> entries,
  ) => [
    for (var i = 0; i < entries.length; i++)
      RevenueChartPoint(
        tooltipKey: entries[i].key,
        value: entries[i].value,
        label: i % 5 == 0 ? entries[i].key.split('-').last : '',
      ),
  ];

  /// Monthly revenue entries → points. Label is the month segment of
  /// `yyyy-MM` (e.g. `04`).
  static List<RevenueChartPoint> monthly(
    List<MapEntry<String, double>> entries,
  ) => [
    for (final e in entries)
      RevenueChartPoint(
        tooltipKey: e.key,
        value: e.value,
        label: _monthSegment(e.key),
      ),
  ];

  static String _monthSegment(String key) {
    final parts = key.split('-');
    return parts.length >= 2 ? parts[1] : '';
  }
}
