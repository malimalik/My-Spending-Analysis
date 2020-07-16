import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartDisplay extends StatelessWidget {
  final String chartLabel;
  final double totalSum;
  final double pctSpent;

  //this constructor creates an instance for the chart display, contians the label, spending for the day and the percentage of money spent

  ChartDisplay(this.chartLabel, this.totalSum, this.pctSpent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: FittedBox(child: Text('\$${totalSum.toStringAsFixed(0)}')),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            Container(
              height: constraints.maxHeight * 0.5,
              width: 50,
              child: new CircularPercentIndicator(
                radius: 50,
                animation: true,
                center: new Text(
                  (pctSpent.toStringAsFixed(2)),
                  style: new TextStyle(fontSize: 10.00),
                ),
                animationDuration: 1200,
                percent: pctSpent,
                backgroundColor: Colors.grey,
                progressColor: Colors.red,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.01),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  height: constraints.maxHeight * 0.2, child: Text(chartLabel)),
            ),
          ],
        );
      },
    );
  }
}
