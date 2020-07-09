//this transaction list class will be a stateful widget because
//it changes based on the user input

//this widget contains the list of the transactions

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/transaction.dart';
import 'package:intl/intl.dart';
//the above is for the dateformat package

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

//incoming transactions are saved here
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        //listview has infinite height and that is why you need to wrap it
        //around the container, it needs a constraint
        child: transactions.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                        'It appears that you have no transactions yet, press the add button on the bottom right corner to get started.'),
                  ),
                  SizedBox(height: 50),
                  Image.network(
                    'https://www.pngitem.com/pimgs/m/434-4341211_transparent-guy-thinking-png-illustration-question-mark-idea.png',
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.amber,
                    shadowColor: Colors.orange,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.orange, blurRadius: 24.0),
                            ],
                            border:
                                Border.all(width: 2, style: BorderStyle.solid),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}', //the builder method allows us to access each transaction according to indexing
                            textAlign: TextAlign.left,
                            style: GoogleFonts.aBeeZee(color: Colors.black),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, //sets the date to the left

                            children: <Widget>[
                              Text(
                                transactions[index].title,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.aBeeZee(color: Colors.black),
                              ),
                              Text(
                                DateFormat.yMMMMEEEEd()
                                    .add_jm()
                                    .format(transactions[index].time),
                                //formats as the time and the date in the format
                                //such as June 12, 2020, time

                                textAlign: TextAlign.left,
                                style: GoogleFonts.aBeeZee(color: Colors.black),
                              ),
                            ]),
                      ],
                    ),
                  );
                },
                itemCount: transactions
                    .length, //tells the build method how many transactions to build
              )
        // scrollDirection: Axis.vertical,
        //we want column because we want to hold multiple transactions, which is a map of transations, we are also calling the toList method
        );
  }
}
