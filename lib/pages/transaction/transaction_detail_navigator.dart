import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/stage_model.dart';
import 'package:mobile/model/transaction_model.dart';

import '../../model/commission_detail_model.dart';
import '../../services/stage_service.dart';
import '../../services/transaction_service.dart';
import 'package:mobile/widgets/dropdown.dart';

class TransactionDetailNavigator extends StatefulWidget {
  const TransactionDetailNavigator({super.key});

  @override
  State<TransactionDetailNavigator> createState() =>
      _TransactionDetailNavigatorState();
}

class _TransactionDetailNavigatorState
    extends State<TransactionDetailNavigator> {
  TransactionModel transaction = TransactionModel();
  StageModel stage = StageModel();
  List<bool> checkboxValues = [];
  bool showButton = true;
  late final TextEditingController _commission = TextEditingController();
  ValueNotifier<String> _selectedRatingValue = ValueNotifier('0');
  List<String> _values = [
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getTransaction().then((value) => getStageDetail());
      setState(() {});
    });
  }

  @override
  void dispose() {
    _commission.dispose();
    super.dispose();
  }

  Future<void> getTransaction() async {
    TransactionModel transactionArgument =
        ModalRoute.of(context)!.settings.arguments as TransactionModel;
    transaction = transactionArgument;
  }

  Future<void> getStageDetail() async {
    StageModel stageAPI =
        await StageService.getStageDetail(transaction.stage?.stage_id ?? '');
    //print(stageAPI.commissionDetails?.length);
    setState(() {
      stage = stageAPI;
      checkboxValues = stage.commissionDetails?.map((detail) {
            return transaction.checked?.contains(detail.commissionDetailId) ??
                false;
          }).toList() ??
          [];
    });
  }

  Future<void> getTransactionDetail() async {
    print(transaction.id);
    TransactionModel transactionAPI =
        await TransactionService.getTransactionDetail(transaction.id ?? '');
    setState(() {
      transaction = transactionAPI;
    });
  }

  Future<bool> updateCheckedTransaction() async {
    bool updated = await TransactionService.updateCheckedTransaction(
        transaction.id ?? '', transaction.checked ?? []);
    return updated;
  }

  Future<int> updateNextStage() async {
    if (_commission.text == '') {
      _commission.text = '0';
    }
    int updated = await TransactionService.updateNextStage(transaction.id ?? '',
        int.parse(_commission.text), int.parse(_selectedRatingValue.value));
    return updated;
  }

  bool areAllCheckboxesChecked() {
    return checkboxValues.every((bool value) => value);
  }

  bool checkStatus() {
    return transaction.status == 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết giao dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (checkStatus() == false)
            ? Column(children: [
                Text(
                  transaction.processData?.name ?? '',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text('Trạng thái: ${transaction.status}'),
                Text('Hoa tiêu: ${transaction.userTransaction?.name ?? 'N/A'}'),
                Text('Giai đoạn hiện tại: ${transaction.stage?.name ?? ' '}'),
                SingleChildScrollView(
                  child: Column(
                    children:
                        stage.commissionDetails?.asMap().entries.map((entry) {
                              int index = entry.key;
                              CommissionDetailModel detail = entry.value;
                              return CheckboxListTile(
                                title: Text(detail.name ?? ''),
                                value: checkboxValues[index],
                                onChanged: null,
                              );
                            }).toList() ??
                            [],
                  ),
                ),
              ])
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Giao dịch đã hoàn thành',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
      ),
    );
  }
}
