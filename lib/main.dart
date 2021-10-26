import 'dart:io';
import 'dart:ui';

import 'package:expense_tracer/widgets/chart.dart';
import 'package:expense_tracer/widgets/Transactions_list.dart';
import 'package:expense_tracer/widgets/new_Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Transactions.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          )),
      title: 'Expense tracer',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransaction = [
    /*Transaction(
      id: 't1',
      title: 'Clothing',
      amount: 1500.00,
      day: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Grocerry',
      amount: 300,
      day: DateTime.now(),
    ),*/
  ];

  void addTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        day: chosenDate);
    setState(() {
      userTransaction.add(newtx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.day!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool switchVAlue = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text("Expense tracer"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: Transactionlist(userTransaction, deleteTransaction));
    final pageBody = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("To Display Chart",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Switch.adaptive(
                    value: switchVAlue,
                    onChanged: (val) {
                      setState(() {
                        switchVAlue = val;
                      });
                    })
              ],
            ),
          if (!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: chart(recentTransaction)),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            switchVAlue
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: chart(recentTransaction))
                : txListWidget,
        ],
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: pageBody,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
