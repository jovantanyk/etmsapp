import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DatePickerNotifier extends BaseViewModel {
  /// DatePicker Notifier manages state for DateTextField widget

  String selectedDate = "";

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != DateTime.now()) {
      selectedDate = DateFormat.yMd("en_US").format(picked);
      controller.text = selectedDate;
      notifyListeners();
    }
  }



}
