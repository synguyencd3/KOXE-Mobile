import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/process_model.dart';
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
  process processData = process();

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

  // Future<void> getTransactionDetail() async {
  //   print(transaction.id);
  //   TransactionModel transactionAPI =
  //       await TransactionService.getTransactionDetail(transaction.id ?? '');
  //   setState(() {
  //     transaction = transactionAPI;
  //   });
  // }
  Future<void> getProcessDetail() async {
    print(transaction.processData?.id);
    var processAPI = await TransactionService.getProcessDetail(
        transaction.processData?.id ?? '');
    processData = processAPI;
  }

  Future<bool> updateCheckedTransaction() async {
    bool updated = await TransactionService.updateCheckedTransaction(
        transaction.id ?? '', transaction.checked ?? []);
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
                  Text(
                      'Trạng thái: ${transaction.status == 'pending' ? 'Chưa hoàn thành' : transaction.status == 'success' ? 'Đã hoàn thành' : 'Đã hủy'}'),
                  Text(
                      'Hoa tiêu: ${transaction.userTransaction?.name ?? 'Bạn'}'),
                  Text('Giai đoạn hiện tại: ${transaction.stage?.name ?? ''}'),
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
              : FutureBuilder(
                  future: getProcessDetail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        Text(
                          'Giao dịch đã hoàn thành',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green),
                        ),
                        Column(
                          children:
                              processData.stages!.asMap().entries.map((entry) {
                            int index = entry.key;
                            var stage = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(stage.name ?? ''),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          transaction.ratingList?[index]=='-1' ? 'Chưa đánh giá':'Phần trăm hoàn thành: ${transaction.ratingList?[index] ?? 0}%'),
                                      Text(
                                          'Hoa hồng: ${transaction.commissionList?[index] ?? 0}'),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    );
                  })),
    );
  }
}
