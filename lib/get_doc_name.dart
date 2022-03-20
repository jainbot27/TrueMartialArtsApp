int getDocName(DateTime dt) {
  // should give a hash value for a date time
  int year = dt.year;
  int month = dt.month;
  int day = dt.day;
  int sum = year * 40 * 13 + 40 * month + day;
  return sum;
}

DateTime getDT(int hash) {
  int _year = (hash / (40 * 13)).floor();
  int _month = ((hash % (40 * 13)) / 40).floor();
  int _day = hash % 40;
  DateTime dt = new DateTime(_year, _month, _day);
  return dt;
}
