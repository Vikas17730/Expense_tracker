import 'package:flutter/foundation.dart';

class Transaction {
  final String? id;
  final String? title;
  final double? amount;
  DateTime? day;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.day,
  });
}
