import 'package:flutter/material.dart';

class DisplayExpense extends StatefulWidget {
  @override
  _DisplayExpenseState createState() => _DisplayExpenseState();
}

class _DisplayExpenseState extends State<DisplayExpense> {
  final List<String> day_of_week = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Card(
          //the reason why we are using container here is because we want to set the width of the card.
          //indeed, we could make use of a column but the column only takes as much space as the child needs.
          child: Container(
              // width: 500,
              child: Text(
            day_of_week.first,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
          color: Colors.red,
          elevation: 5,
        ),
        Card(
          //the reason why we are using container here is because we want to set the width of the card.
          //indeed, we could make use of a column but the column only takes as much space as the child needs.
          child: Container(
              // width: 500,
              child: Text(
            day_of_week.elementAt(1),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
          color: Colors.red,
          elevation: 5,
        ),
        Card(
          shadowColor: Colors.deepOrange,
          //the reason why we are using container here is because we want to set the width of the card.
          //indeed, we could make use of a column but the column only takes as much space as the child needs.
          child: Container(

              // width: 500,
              child: Text(
            day_of_week.elementAt(2),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
          color: Colors.red,
          elevation: 5,
          
        ),
        Card(
          //the reason why we are using container here is because we want to set the width of the card.
          //indeed, we could make use of a column but the column only takes as much space as the child needs.
          child: Container(
              // width: 500,
              child: Text(
            day_of_week.elementAt(3),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
          color: Colors.red,
          elevation: 5,
        ),
      ],
    );
  }
}
