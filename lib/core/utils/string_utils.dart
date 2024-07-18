class StringUtils {
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final maskedPart =
        parts[0].length > 3 ? '${parts[0].substring(0, 3)}****' : '****';

    return '$maskedPart@${parts[1]}';
  }
}
