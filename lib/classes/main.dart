//important thing to note here is that flutter makes use of what it calls widget tree
//TIP: when it doubt, wrap it around a container and it will probably work
// The container is able to have its own width whereas the column just takes as as much space as its child.

import 'dart:io';
import 'package:flutter/cupertino.dart';
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
    return Platform.isIOS
        ? CupertinoApp(
            title: 'My Expenses',
            theme: CupertinoThemeData(
              primaryColor: Colors.red,
            ),
            home: MyHomePage(),
          )
        : MaterialApp(
            title: 'My Expenses',
            theme: ThemeData(
              primarySwatch: Platform.isIOS ? Colors.purple : Colors.red,
              errorColor: Platform.isIOS ? Colors.purple : Colors.red,
              accentColor:
                  Platform.isIOS ? Colors.purple : Colors.deepOrangeAccent,
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

  //the following property is used in the material/cupertiono button for displaying the chart
  bool _dispChart = false;

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
        title: title,
        id: DateTime.now().toString(),
        time: chosenDate);

    setState(() {
      transactions.add(newTrans);
    });
  }

  ///The following method prompts the user to the modal sheet and lets them enter the details of the transaction, that is,
  ///title, amount and date of the transaction

  void promptTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.amber,
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
    final pageBody = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart Only'),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _dispChart,
                onChanged: (val) {
                  setState(() {
                    _dispChart = val;
                  });
                },
              ),
            ],
          ),
          _dispChart
              ? Chart(_recentTransactions)
              :
              //expanded widget forces the child to take all the available height it can get.
              TransactionList(transactions, _deleteTransaction)
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: CupertinoNavigationBar(
              middle: Text("Good Day, Ali!"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.add,
                      color: Colors.black,
                    ),
                    onTap: () => promptTransaction(context),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => promptTransaction(context),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
              toolbarOpacity: 1,
              bottomOpacity: 1,
              title: Text("Good Day, Ali!"),
            ),
            body: pageBody,

            ///the following code checks for the platform, if it is iOS, the floating action button is not rendered
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
