import 'package:expense_tracer/models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  chart(this.recentTransaction);
  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var ts = 0.0;
      var totalsum = ts.toDouble();

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].day!.day == weekDay.day &&
            recentTransaction[i].day!.month == weekDay.month &&
            recentTransaction[i].day!.year == weekDay.year) {
          totalsum += recentTransaction[i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    });
  }

  double get totalspending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: chartBar(
                  (data['day'] as String),
                  (data['amount'] as double),
                  totalspending == 0
                      ? 0.0
                      : (data['amount'] as double) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
