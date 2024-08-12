import 'package:flutter/material.dart';
import 'package:ant_control/models/period.dart';

class PeriodProvider with ChangeNotifier {
  Period? _selectedPeriod;

  Period? get selectedPeriod => _selectedPeriod;

  void setSelectedPeriod(Period? period) {
    _selectedPeriod = period;
    notifyListeners();
  }
}
