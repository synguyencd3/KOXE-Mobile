import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_revenue_model.dart';
import 'package:mobile/widgets/transaction_card.dart';
import '../../services/transaction_service.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/utils/utils.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TransactionRevenueModel transactions = TransactionRevenueModel();
  String isSalon = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIsSalon();
  }

  Future<void> getTransactions() async {
    TransactionRevenueModel transactionsAPI =
        await TransactionService.getTransactions();
    transactions = transactionsAPI;
  }

  Future<void> getIsSalon() async {
    String isSalonAPI = await SalonsService.isSalon();
    setState(() {
      isSalon = isSalonAPI;
    });
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
            return Column(
              children: [
                Text(
                    (isSalon != ''
                            ? 'Tổng chi cho hoa tiêu: '
                            : 'Tổng tiền nhận từ salon: ') +
                        '${formatCurrency(transactions.revenue!)}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                      itemCount: transactions.transaction!.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TransactionCard(
                            transaction: transactions.transaction![index]);
                      }),
                ),
              ],
            );
          }),
    );
  }
}
