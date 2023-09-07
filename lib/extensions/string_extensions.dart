extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension StringLimit on String? {
  String dynamicSub(int limit) =>
      '${(this ?? '').length > limit ? this!.substring(0, limit) : this ?? ''}...';
}
