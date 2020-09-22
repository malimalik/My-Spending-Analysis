//this contains the form widget which allows the user to enter the details of their transaction
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../widgets/adaptiveButton.dart';

//the reason why this is converted into a stateful widget is to make sure the information
//that is filled out on the submit form does not get deleted.
//in a stateless widget, it would get deleted
class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final detailController = TextEditingController();

  DateTime _date = DateTime.now();

  // Date picker widget

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  void submit() {
    if (amountController.text.isEmpty && titleController.text.isEmpty) {
      //if no amount has been entered, the user gets a message to enter the amount
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => AlertDialog(
                title: Text("No Data Entered"),
                content:
                    Text("Please enter an amount, a title and select a date"),
              ));
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    //if the user does not fill out the title field, they get a message
    if (enteredTitle.isEmpty && amountController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("No title detected"),
          content: Text("Please enter a title"),
        ),
      );
      return;
      //if the user enters an invalid amount, such as zero or a negative amount
    } else if (enteredTitle.isNotEmpty &&
        (enteredAmount.isNegative || amountController.text.isEmpty)) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Invalid amount detected"),
          content: Text("Please enter a valid amount"),
        ),
      );
      return;
      //if the user does not choose the date of their transaction
    } else if (_date == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("No date selected"),
          content: Text("Please choose a date"),
        ),
      );
      return;
    } else

      //the .widget property gives me access to the widget properties
      //it is not possible to access the widget's property inside the state function with .widget
      widget.newTransaction(enteredTitle, enteredAmount, _date);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          // height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CupertinoTextField(
                autocorrect: true,
                enableSuggestions: true,
              ),
              TextField(
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    labelText: 'Title', hintText: 'What did you buy?'),
                //these controller are like listeners, they listen to the user
                //input and then save the user input
                controller: titleController,
                //onChanged
              ),
              TextField(
                style: GoogleFonts.aBeeZee(),
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'The cost of your purchase',
                ),
                controller: amountController,
                onSubmitted: (_) => submit(),
                keyboardType: TextInputType.number,
                //onChanged: (val) => amountInput = val,
              ),
              TextField(
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    labelText: 'Details', hintText: 'Details of your purchase'),
                controller: detailController,
                onSubmitted: (_) => submit(),
                //onChanged: (val) => amountInput = val,
              ),
              Row(
                children: <Widget>[
                  Text(_date == null
                      ? 'No Date has been chosen'
                      : DateFormat.yMd().format(_date)),
                ],
              ),
              AdaptiveButton('Date', selectDate),
              RaisedButton.icon(
                onPressed: () {
                  submit();
                },
                padding: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                color: Platform.isIOS ? Colors.purple : Colors.red,
                label: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
