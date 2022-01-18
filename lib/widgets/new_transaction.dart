import 'package:flutter/material.dart';
import '../widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrans;

  NewTransaction(this.addTrans);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTrans(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData,
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Choosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                      ),
                    ),
                    AdaptiveButton('Choose Date', datePicker)
                  ],
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Theme.of(context).textTheme.button.color,
                ),
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
