import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void SubmitData() {
    final enteredtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(enteredtitle, enteredamount, selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
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
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titlecontroller,
                onSubmitted: (_) => SubmitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => SubmitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == Null
                          ? "No Date"
                          : DateFormat.yMd().format(selectedDate)),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              FlatButton(
                color: Colors.purple,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => SubmitData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
