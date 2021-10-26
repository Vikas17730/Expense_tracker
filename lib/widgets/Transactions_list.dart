import 'package:expense_tracer/models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactionlist extends StatelessWidget {
  @override
  final List<Transaction> transactions;
  final Function deleteTx;
  Transactionlist(this.transactions, this.deleteTx);
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'No Transaction added',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    elevation: 7,
                    child: ListTile(
                      leading: CircleAvatar(
                        maxRadius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title.toString(),
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format((transactions[index].day!)),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              label: Text("Delete"),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ));
              },
              itemCount: transactions.length),
    );
  }
}
