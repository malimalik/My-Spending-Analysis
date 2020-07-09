//this contains the form widget which allows the user to enter the details of their transaction
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void submit() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    } else
      //the .widget property gives me access to the widget properties
      //it is not possible to access the widget's property inside the state function with .widget
      widget.newTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      child: Container(
        padding: EdgeInsets.all(10),
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
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
                  labelText: 'Amount', hintText: 'The cost of your purchase',),
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
              color: Colors.red,
              label: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
