import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTx;

  const NewTransaction(this._addTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitNewTransaction() {
    print('into submit new transaction');

    final newTitle = _titleController.text;
    final newAmount = double.parse(_amountController.text);
    if (newTitle == null || newAmount < 0 || _selectedDate == null) {
      print('couldnt submit new transaction');
      return;
    }
    widget._addTx(newTitle, newAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) => {
              if (pickedDate == null)
                {}
              else
                {
                  setState(() {
                    _selectedDate = pickedDate;
                  })
                },
              print(_selectedDate)
            });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  textInputAction: TextInputAction.done,
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'title')),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'amount')),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => _presentDatePicker()),
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDate))
                ],
              ),
              RaisedButton(
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  _submitNewTransaction();
                  _titleController.clear();
                  _amountController.clear();
                  _selectedDate = null;
                },
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
