/// Validates category names used as Firestore values AND Storage path segments.
/// Allowlist: Latin letters, digits, Arabic letters, space, underscore, hyphen.
/// Rejects path-breaking characters (`/`, `\`, `..`) and control/unicode edge cases.
class CategoryNameValidator {
  static const int maxLength = 40;

  static final RegExp _allowed = RegExp(r'^[A-Za-z0-9 \u0600-\u06FF_-]+$');
  static final RegExp _whitespace = RegExp(r'\s+');

  /// Returns the trimmed+normalized name if valid, otherwise `null`.
  static String? normalize(String raw) {
    final trimmed = raw.trim().replaceAll(_whitespace, ' ');
    if (trimmed.isEmpty) return null;
    if (trimmed.length > maxLength) return null;
    if (!_allowed.hasMatch(trimmed)) return null;
    return trimmed;
  }
}
