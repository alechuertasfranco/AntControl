import 'package:flutter/material.dart';
import 'package:ant_control/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:ant_control/adapters/periods_adapter.dart';
import 'package:ant_control/widgets/month_year_picker.dart';
import 'package:ant_control/services/periods_service.dart';
import 'package:ant_control/models/period.dart';
import 'package:ant_control/providers/period_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Period> _periods = [];
  final String registerNewPeriodOption = 'Registrar un nuevo periodo';

  final PeriodsService _periodsService = PeriodsService();
  final PeriodsAdapter _periodsAdapter = PeriodsAdapter();

  @override
  void initState() {
    super.initState();
    _loadPeriods();
  }

  void setSelectedPeriod(Period? period) {
    context.read<PeriodProvider>().setSelectedPeriod(period);
  }

  Future<void> _loadPeriods() async {
    final data = await _periodsService.getPeriods();
    final formattedPeriods = _periodsAdapter.formatPeriodList(data);

    if (mounted) {
      setState(() {
        _periods = [...formattedPeriods, Period(id: 0, year: 0, month: 0, formatted: registerNewPeriodOption)];

        final selectedPeriod = context.read<PeriodProvider>().selectedPeriod;
        if (selectedPeriod != null) {
          final exists = _periods.any((period) => period.id == selectedPeriod.id);
          if (!exists) setSelectedPeriod(null);
        }
        if (selectedPeriod == null) {
          setSelectedPeriod(_periods.last);
        }
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
          final selectedPeriod = _periodsAdapter.formatPeriod(Period(month: date.month, year: date.year));
          setSelectedPeriod(selectedPeriod);
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
    final selectedPeriod = context.watch<PeriodProvider>().selectedPeriod;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedPeriod?.formatted ?? 'Inicio',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary050),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: DropdownButton<int?>(
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
              ],
              onChanged: (int? newValue) {
                if (newValue == 0) {
                  _registerNewPeriod();
                } else if (newValue != null) {
                  final selectedPeriod = _periods.firstWhere((item) => item.id == newValue);
                  setSelectedPeriod(selectedPeriod);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
