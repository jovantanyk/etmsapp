class DateAndTime
{
  static final DateAndTime _singleton = DateAndTime._internal();
  factory DateAndTime()
  {
    return _singleton;
  }
  String dateTimeToDate(DateTime dt)
  {
    var now = dt;
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    return currentDate;
  }

  String dateTimeToTime(DateTime dt)
  {
    var now = dt;
    String currentTime = now.hour.toString().padLeft(2, '0') + now.minute.toString().padLeft(2, '0') + now.second.toString().padLeft(2, '0');
    return currentTime;
  }

  String getCurrentTime()
  {
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentTime = now.hour.toString().padLeft(2, '0') + now.minute.toString().padLeft(2, '0') + now.second.toString().padLeft(2, '0');
    return currentTime;
  }

  String getCurrentDate()
  {
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    return currentDate;
  }

  DateTime dateAndTimetoDateTime(String date, String time)
  {
    var rawdate = date.split('/');
    var datetime = DateTime.utc(
        int.parse(rawdate[2]),
        int.parse(rawdate[1]),
        int.parse(rawdate[0]),
        int.parse(time.substring(0, time.length - 4)),
        int.parse(time.substring(2, time.length - 2)),
        int.parse(time.substring(4, time.length)));
    return datetime;
  }

  DateTime getGMT(DateTime dt) {
    var now = DateTime.parse(dt.toString());
    return now;
  }

  String getDisplayCurrentTime()
  {
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentTime = now.hour.toString().padLeft(2, '0') + ":" + now.minute.toString().padLeft(2, '0');
    return currentTime;

  }

  String convertDBTimetoTime(String time){
    return time.substring(0, 2) + ":" + time.substring(2, 4);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  DateAndTime._internal();
}