import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;

  Chart(this.transaction);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(Duration(days: index));
      double total;

      for (var i = 0; i < transaction.length; i++) {
        if (transaction[i].date.day == weekday.day &&
            transaction[i].date.month == weekday.month &&
            transaction[i].date.year == weekday.year) {
          total += transaction[i].amount;
        }
      }

      return {'day': DateFormat.E(weekday), 'amount': total};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
