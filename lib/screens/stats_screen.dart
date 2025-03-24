import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/receipt_model.dart';

class StatsScreen extends StatelessWidget {
  final List<Receipt> receipts;

  const StatsScreen({super.key, required this.receipts});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> monthlyTotals = {};

    for (var receipt in receipts) {
      final key =
          "${receipt.date.year}-${receipt.date.month.toString().padLeft(2, '0')}";
      monthlyTotals[key] = (monthlyTotals[key] ?? 0) + receipt.amount;
    }

    final sortedKeys = monthlyTotals.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text("إحصائيات المصروفات"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY:
                (monthlyTotals.values.isNotEmpty
                    ? monthlyTotals.values.reduce((a, b) => a > b ? a : b)
                    : 10000) *
                1.2,
            gridData: FlGridData(show: true, drawVerticalLine: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.black, width: 1),
                left: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < sortedKeys.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          sortedKeys[index],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            barGroups: List.generate(sortedKeys.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: monthlyTotals[sortedKeys[i]]!,
                    width: 20,
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [Colors.teal, Colors.greenAccent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
