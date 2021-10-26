import 'package:flutter/material.dart';

class chartBar extends StatelessWidget {
  final String label;
  final double spendAmo;
  final double percSpendAmo;
  chartBar(this.label, this.spendAmo, this.percSpendAmo);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: <Widget>[
          Container(
              height: constraint.maxHeight * 0.15,
              child:
                  FittedBox(child: Text("\$${spendAmo.toStringAsFixed(0)}"))),
          SizedBox(height: constraint.maxHeight * 0.05),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percSpendAmo,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
