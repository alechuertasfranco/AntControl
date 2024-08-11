import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthYearPicker extends StatefulWidget {
  final Function(DateTime) onMonthYearSelected;

  const MonthYearPicker({super.key, required this.onMonthYearSelected});

  @override
  MonthYearPickerState createState() => MonthYearPickerState();
}

class MonthYearPickerState extends State<MonthYearPicker> {
  DateTime _selectedDate = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _selectedDate,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                // Update calendar format
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.onMonthYearSelected(_selectedDate);
            },
            child: const Text('Seleccionar Periodo'),
          ),
        ],
      ),
    );
  }
}
