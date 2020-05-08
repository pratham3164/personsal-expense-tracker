import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendPercentageOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendPercentageOfTotal});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, cons) {
      return Column(
        children: <Widget>[
          Container(
              height: cons.maxHeight * 0.1,
              width: 30,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: cons.maxHeight * 0.05),
          Container(
              height: cons.maxHeight * 0.65,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendPercentageOfTotal,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              )),
          SizedBox(height: cons.maxHeight * 0.05),
          Text(label)
        ],
      );
    });
  }
}
