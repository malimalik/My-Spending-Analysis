//important thing to note here is that flutter makes use of what it calls widget tree
//TIP: when it doubt, wrap it around a container and it will probably work
// The container is able to have its own width whereas the column just takes as as much space as its child.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_first_assignment/widgets/chart.dart';
import 'package:my_first_assignment/widgets/new_transactions.dart';
import 'package:my_first_assignment/widgets/transaction_list.dart';
import 'package:flutter/services.dart';

import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';

import '../classes/transaction.dart';

//import 'package:google_fonts/google_fonts.dart';

void main() {
  //it does not make sense for the app to run in landscape orientation and therefore I have restricted it to portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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

  // this method deletes the transactions, it is a void method and requires to change the state,
  //that is why it is inside a stateful widget rather than a stateless widget
  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((_recentTransactions) {
        return _recentTransactions.id == id;
      });
    });
  }

///This function gets the recent transactions from the past week since the app calculates weekly expenses

  List<Transaction> get _recentTransactions {
    return transactions.where((transaction) {
      return transaction.time.isAfter(
        DateTime.now().subtract(
          //the transactions that are younger than seven days
          Duration(days: 7),
        ),
      );
      //to list returns a list of transactions from the past week as the where function returns only an iterable.
    }).toList();
  }

  /// This is the method that actually creates the new transaction
  /// it stores the instance variables data for the title and the amount
  void _newTransaction(String title, double amount, DateTime chosenDate) {
    final newTrans = Transaction(
        amount: amount,
        title : title,
        id: DateTime.now().toString(),
        time: chosenDate);

    setState(() {
      transactions.add(newTrans);
    });
  }

  ///This is the method that is implemented when you the add transaction button is pressed
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
      //we actually check the platform and if the platform is IOS then we do not render the material button as it is part of the material icon kit
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              tooltip: 'Add a new transaction',
              child: Icon(Icons.add),
              onPressed: () => promptTransaction(context),
              hoverColor: Colors.purple,
            ),
    );
  }
}
