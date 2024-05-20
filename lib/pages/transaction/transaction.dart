import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_model.dart';
import 'package:mobile/widgets/transaction_card.dart';
import '../../services/transaction_service.dart';
import 'package:mobile/pages/loading.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<TransactionModel> transactions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
  }

  Future<void> getTransactions() async {
    List<TransactionModel> transactionsAPI =
        await TransactionService.getTransactions();
    transactions = transactionsAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý giao dịch hoa tiêu'),
      ),
      body: FutureBuilder(
          future: getTransactions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView.builder(
                itemCount: transactions.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return TransactionCard(transaction: transactions[index]);
                });
          }),
    );
  }
}
