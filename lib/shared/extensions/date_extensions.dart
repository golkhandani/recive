extension DateTimeGQL on DateTime {
  static DateTime forceConvert(String? formattedString) =>
      formattedString != null
          ? DateTime.tryParse(formattedString) ?? DateTime.now()
          : DateTime.now();
}
