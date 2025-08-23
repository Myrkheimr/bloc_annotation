abstract final class StringUtils {
  static String capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) return "";

    return input
        .split(' ')
        .map(
          (w) =>
              '${w[0].toUpperCase()}'
              '${w.toLowerCase().substring(1)}',
        )
        .join();
  }
}
