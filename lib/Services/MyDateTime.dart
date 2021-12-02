class MyDateTime {
  DateTime dateTime = DateTime.now();

 

  DateTime getDateTime() {
    return dateTime;
  }

  int getCurrentYear() {
    return dateTime.year;
  }

  int getCurrentMonth() {
    return dateTime.month;
  }

  int getCurrentDay() {
    return dateTime.day;
  }

  int getCurrentHour24() {
    return dateTime.hour;
  }

  int getCurrentHour12() {
    int hour;
    if (dateTime.hour >= 0 && dateTime.hour < 12) {
      if (dateTime.hour == 0) {
        hour = 12;
      } else {
        hour = dateTime.hour;
      }
    } else {
      hour = dateTime.hour - 12;
      if (hour == 0) {
        hour = 12;
      } else {
        hour = dateTime.hour - 12;
      }
    }
    return hour;
  }

  int getCurrentMinute() {
    return dateTime.minute;
  }

  int getCurrentSecond() {
    return dateTime.second;
  }

  String getAmPm() {
    String time;
    if (dateTime.hour >= 0 && dateTime.hour < 12) {
      time = "AM";
    } else {
      time = "PM";
    }

    return time;
  }

  String getMorningNoonEvening() {
    int currentHour = dateTime.hour;
    if (currentHour >= 12 && currentHour <= 18) {
      return "Good Afternoon";
    } else if (currentHour >=0 && currentHour <12) {
      return "Good Morning";
    } else if (currentHour >18 && currentHour <= 23) {
      return "Good Evening";
    } else {
      return "Good Day";
    }
  }
}
