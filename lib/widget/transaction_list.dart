import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpense_app/models/transacton.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> _usertransaction;
  final Function deleteTx;

  TransactionList(this._usertransaction, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget._usertransaction.isEmpty
        ? Center(
            child: Text('No Transactions Yet'),
          )
        : ListView.builder(
            itemCount: widget._usertransaction.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                          child: Text(
                            '\$${widget._usertransaction[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(widget._usertransaction[index].title),
                    subtitle: Text(DateFormat.yMMMMd()
                        .format(widget._usertransaction[index].date)),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print('delete');
                          widget.deleteTx(widget._usertransaction[index].id);
                        }),
                  ),
                ),
              );
            },
          );
  }
}
