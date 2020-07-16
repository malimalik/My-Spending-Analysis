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
  Function deleteTx;

//incoming transactions are saved here
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      //listview has infinite height and that is why you need to wrap it
      //around the container, it needs a constraint
      child: transactions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'It appears that you have no transactions yet, press the add button on the bottom right corner to get started.',
                    style: GoogleFonts.adventPro(),
                  ),
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
                  color: Colors.white,
                  shadowColor: Colors.orange,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, style: BorderStyle.none),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}', //the builder method allows us to access each transaction according to indexing
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(color: Colors.black),
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, //sets the date to the left

                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.yMd().format(transactions[index].time),

                              //formats as the time and the date in the format
                              //such as June 12, 2020, time

                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(color: Colors.black),
                            ),
                          ]),
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions
                  .length, //tells the build method how many transactions to build
            ),

      // scrollDirection: Axis.vertical,
      //we want column because we want to hold multiple transactions, which is a map of transations, we are also calling the toList method
    );
  }
}
