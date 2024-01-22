import 'package:intl/intl.dart';

class ExtractDate{
  static String extractDate(String dateTimeString) {
    DateTime dateTime = DateFormat('dd.MM.yyyy HH:mm:ss').parse(dateTimeString);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static List<String> formatListOfDates(List<String?> dates) {
    List<String> formattedDates = [];

    for (String? dateStr in dates) {
      if(dateStr!=null){
        String formattedDate = extractDate(dateStr) ;
        formattedDates.add(formattedDate);
      }

    }

    return formattedDates;
  }

}