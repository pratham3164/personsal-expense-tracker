import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpense_app/widget/chart_bar.dart';
import '../models/transacton.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;

      for (int i = 0; i < recentTransactions.length; i++) {
        final tx = recentTransactions[i].date;
        if (tx.day == weekday.day &&
            tx.month == weekday.month &&
            tx.year == weekday.year) {
          totalsum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValue.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Card(
      elevation: 6,
      child: Container(
        height: mediaQuery * 0.3,
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValue
              .map((data) => ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendPercentageOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
