import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_model.dart';

class TransactionCard extends StatefulWidget {
  TransactionModel transaction;
   TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/transaction_detail',
            arguments: widget.transaction);
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Tên qui trình'),
             trailing:  Text(widget.transaction.processData!.name!),
            ),
            ListTile(
              title: Text('Trạng thái'),
              trailing: Text(widget.transaction.status!),
            ),
            ListTile(
              title: Text('Hoa tiêu'),
              trailing: Text(widget.transaction.userTransaction?.name ?? 'N/A'),
            ),
          ],
        ),
      ),
    );
  }
}
