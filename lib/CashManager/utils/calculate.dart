import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../models/money.dart';
//
Box<Money> hiveBox = Hive.box<Money>('moneyBox');
//
String year = Jalali.now().year.toString();
String month = Jalali.now().month.toString().length == 1
    ? '0${Jalali.now().month.toString()}'
    : Jalali.now().month.toString();
String day = Jalali.now().day.toString().length == 1
    ? '0${Jalali.now().day.toString()}'
    : Jalali.now().day.toString();
//
class Calculate {
  static String today() {
    return '$year/$month/$day';
  }

  static double pToDay() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date == today() && value.isReceived == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double dToDay() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date == today() && value.isReceived == true) {
        result += double.parse(value.price);
      }
    }
    return result;
  }

  static double pToMonth() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(5,7) == month && value.isReceived == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }

  static double dToMonth() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(5,7)  == month && value.isReceived == true) {
        result += double.parse(value.price);
      }
    }
    return result;
  }


  static double pToYear() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,4)  == year && value.isReceived == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }


  static double dToYear() {
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,4)  == year && value.isReceived == true) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
}
