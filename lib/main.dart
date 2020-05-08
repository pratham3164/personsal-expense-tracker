import 'package:flutter/material.dart';
import 'package:personalexpense_app/models/transacton.dart';
import 'package:personalexpense_app/widget/chart.dart';
import 'package:personalexpense_app/widget/new_transaction.dart';
import 'package:personalexpense_app/widget/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.teal[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: Colors.white),
        buttonColor: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];
  bool _showchart = true;

  void _addNewTransaction(String title, double amt, DateTime date) {
    final Transaction tx =
        Transaction(id: date.toString(), title: title, amount: amt, date: date);
    setState(() {
      transactions.add(tx);
    });
  }

  void _presentModalBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (_) => NewTransaction(_addNewTransaction));
  }

  void _deleteTransaction(String id) {
    print('inside delete Transaction');
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget = Container(
      height: mediaQuery * 0.70,
      child: TransactionList(transactions, _deleteTransaction),
    );

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: _presentModalBottomSheet)
      ],
    );

    final page = SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    },
                  )
                ],
              ),
            if (!_isLandscape)
              Container(
                height: mediaQuery * 0.3,
                child: Chart(recentTransactions),
              ),
            if (!_isLandscape) txListWidget,
            if (_isLandscape)
              _showchart
                  ? Container(
                      height: mediaQuery * 0.8,
                      child: Chart(recentTransactions),
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: page,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isLandscape
          ? null
          : FloatingActionButton(
              onPressed: () => _presentModalBottomSheet(),
              child: Icon(Icons.add),
            ),
    );
  }
}
