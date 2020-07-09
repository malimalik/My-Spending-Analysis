import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_assignment/widgets/chart_display.dart';
import '../classes/transaction.dart';
import '../widgets/chart_display.dart';

class Chart extends StatelessWidget {
//we need to create an instance of all the new transactions to be able to add them to the chart
  final List<Transaction> recentTransactions;

//the chart constructor gets the recent transactions
  Chart(this.recentTransactions);

//string is used for the days and for the amount object is used

  List<Map<String, Object>> get groupedTransactionValues {
    //here we have created a list of 7 objects because there are seven days in a week
    return List.generate(7, (index) {
      //please note that the below actually uses the built in subtract method to get the current day
      final WoD = DateTime.now().subtract(
        Duration(days: index),
      );

      //the cumulative sum of the transaction, initialized to zero
      double cumSum = 0;

      //running the for loop accesses the right transaction and filters them according
      //to the day, the month and the year

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].time.day == WoD.day &&
            recentTransactions[i].time.month == WoD.month &&
            recentTransactions[i].time.year == WoD.year)
          cumSum = cumSum + recentTransactions[i].amount;
      }
      print(DateFormat.E().format(WoD));
      print(cumSum);

      return {
        'Day': DateFormat.E().format(WoD),
        'Amount': cumSum,
      };
    }).reversed.toList();
  }

  //a method to calculate the percentage of a day's spending, as in the current day.

  double get percentSpent {
    return groupedTransactionValues.fold(0.0, (sum, current) {
      return sum + current['Amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return ChartDisplay(
                data['Day'],
                data['Amount'],
                percentSpent == 0.0
                    ? 0.00
                    : (data['Amount'] as double) / percentSpent);
          }).toList(),
        )),
      ),
    );
  }
}
