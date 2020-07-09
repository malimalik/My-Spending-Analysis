//the foundation dart package is the one that actually allows to put the requirement as required
import 'package:flutter/foundation.dart';

//this is not a widget that will be added
//just shows what a transaction should look like

class Transaction {
// Indeed, we need the following instance variables that
//are the properties of the transaction
//using final beacuse they are runtime constant and get
//their value in the runtime but the value never changes

  final String id;

  final DateTime time;
  //this is a type that is built in dart
  final String title;
  final double amount;

  Transaction({
  @required this.id, 
  @required this.time, 
  @required this.title, 
  @required this.amount});
}
