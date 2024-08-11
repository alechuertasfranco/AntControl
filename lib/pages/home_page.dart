import 'package:flutter/material.dart';
import 'package:ant_control/adapters/periods_adapter.dart';
import 'package:ant_control/widgets/month_year_picker.dart';
import '../services/periods_service.dart';
import '../models/period.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Period> _periods = [];
  final String registerNewPeriodOption = 'Registrar un nuevo periodo';
  Period? selectedPeriod;

  final PeriodsService _periodsService = PeriodsService();
  final PeriodsAdapter _periodsAdapter = PeriodsAdapter();

  @override
  void initState() {
    super.initState();
    _loadPeriods();
  }

  Future<void> _loadPeriods() async {
    final data = await _periodsService.getPeriods();
    final formattedPeriods = _periodsAdapter.formatPeriodList(data);
    if (mounted) {
      setState(() {
        _periods = formattedPeriods;
      });
    }
  }

  Future<void> _registerNewPeriod() async {
    final result = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: MonthYearPicker(
            onMonthYearSelected: (DateTime date) {
              Navigator.of(context).pop(date);
            },
          ),
        );
      },
    );

    if (result != null) {
      final date = result;
      final success = await _periodsService.addPeriod(date.year, date.month);
      if (mounted) {
        if (success) {
          await _loadPeriods();
          setState(() {
            selectedPeriod = _periodsAdapter.formatPeriod(Period(month: date.month, year: date.year));
          });
          showScaffoldMessage(const Text('Periodo registrado con éxito'));
        } else {
          showScaffoldMessage(const Text('Error al registrar el periodo'));
        }
      }
    }
  }

  void showScaffoldMessage(Text text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPeriod?.formatted ?? 'Inicio'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: DropdownButton<int>(
              value: selectedPeriod?.id,
              hint: const Text('Selecciona un periodo'),
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              items: [
                ..._periods.map((Period period) {
                  return DropdownMenuItem<int>(
                    value: period.id,
                    child: Text(period.formatted ?? ''),
                  );
                }),
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text(registerNewPeriodOption),
                ),
              ],
              onChanged: (int? newValue) {
                if (newValue == 0) {
                  _registerNewPeriod();
                } else {
                  setState(() {
                    selectedPeriod = _periods.firstWhere((item) => item.id == newValue);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
