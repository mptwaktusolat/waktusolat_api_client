class HijriDate {
  final List<String> _hijriNames = [
    "Muharram",
    "Safar",
    "Rabi'ulawal",
    "Rabi'ulakhir",
    "Jamadilawwal",
    "Jamadilakhir",
    "Rejab",
    "Sya'ban",
    "Ramadhan",
    "Syawwal",
    "Zulkaedah",
    "Zulhijjah",
  ];

  final List<String> _shortHijriNames = [
    "Muh",
    "Saf",
    "Raw",
    "Rak",
    "Jaw",
    "Jak",
    "Rej",
    "Syb",
    "Ram",
    "Syw",
    "Zkh",
    "Zhj",
  ];

  late int day, month, year;
  late String monthName;
  late String shortMonthName;

  HijriDate(this.year, this.month, this.day) {
    monthName = _hijriNames[month - 1];
    shortMonthName = _shortHijriNames[month - 1];
  }

  HijriDate.parse(String hijriDate) {
    final date = hijriDate.split('-');
    year = int.parse(date[0]);
    month = int.parse(date[1]);
    day = int.parse(date[2]);
    monthName = _hijriNames[month - 1];
    shortMonthName = _shortHijriNames[month - 1];
  }

  factory HijriDate.fromJson(String json) => HijriDate.parse(json);

  String toJson() =>
      "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

  String dMY() => "$day $shortMonthName $year";
  String dM() => "$day $shortMonthName";
  String dMMM() => "$day $monthName";

  @override
  String toString() => "$day $monthName $year";

  @override
  bool operator ==(Object other) =>
      other is HijriDate &&
      day == other.day &&
      month == other.month &&
      year == other.year;

  @override
  int get hashCode => dMY().hashCode;
}
