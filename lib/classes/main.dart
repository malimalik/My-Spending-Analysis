//important thing to note here is that flutter makes use of what it calls widget tree
//TIP: when it doubt, wrap it around a container and it will probably work
// The container is able to have its own width whereas the column just takes as as much space as its child.

import 'package:flutter/material.dart';
import 'package:my_first_assignment/widgets/chart.dart';
import '../widgets/chart.dart';
import 'package:my_first_assignment/widgets/new_transactions.dart';
import 'package:my_first_assignment/widgets/transaction_list.dart';
import '../widgets/transaction_list.dart';
import '../classes/transaction.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        errorColor: Colors.red,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//Here I am able to create a list of transactions
//because of the transaction file that I just imported

//the following method prompts the user to the form to add the details
//about the transaction
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((_recentTransactions) {
        return _recentTransactions.id == id;
      });
    });
  }

//this function gets the recent transactions from the past week only as I wish to display
//the transactions from Monday to Sunday only

  List<Transaction> get _recentTransactions {
    return transactions.where((transaction) {
      return transaction.time.isAfter(
        DateTime.now().subtract(
          //the transactions that are younger than seven days
          Duration(days: 7),
        ),
      );
      //to list returns a list as the where returns only an iterable
    }).toList();
  }

  /// this is the method that actually creates the new transaction
  /// it stores the instance variables data for the title and the amount
  void _newTransaction(String title, double amount, DateTime chosenDate) {
    final newTrans = Transaction(
        amount: amount,
        title: title,
        id: DateTime.now().toString(),
        time: chosenDate);

    setState(() {
      transactions.add(newTrans);
    });
  }

  //this element takes the selected transaction and removes it when a certain condtion is met

  ///this is the method that is implemented when you the add transaction button is pressed
  ///this method prompts the user to the modal sheet and lets them enter the details of the transaction

  void promptTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.grey,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_newTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1,
        bottomOpacity: 1,
        title: Text("Good Day, Ali!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),

            //expanded widget forces the child to take all the available height it can get
            TransactionList(transactions, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: Tooltip(
        message: "Add new transaction",
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => promptTransaction(context),
          hoverColor: Colors.purple,
        ),
      ),
    );
  }
}
