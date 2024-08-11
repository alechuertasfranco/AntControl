import 'package:flutter/material.dart';
import '../models/period.dart';

class PeriodProvider with ChangeNotifier {
  Period? _selectedPeriod;

  Period? get selectedPeriod => _selectedPeriod;

  void setSelectedPeriod(Period period) {
    _selectedPeriod = period;
    notifyListeners();
  }
}
