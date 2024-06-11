import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_model.dart';
import 'package:mobile/services/transaction_service.dart';
import 'package:mobile/services/salon_service.dart';

class TransactionCard extends StatefulWidget {
  TransactionModel transaction;

  TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  bool isDeleted = false;
  Set<String> permission = {};

  Future<bool> deleteTransaction(String transactionId) async {
    bool response = await TransactionService.deleteTransaction(transactionId);
    return response;
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDeleted
        ? Container()
        : Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Tên qui trình'),
                  trailing: Text(widget.transaction.processData!.name!),
                ),
                ListTile(
                  title: Text('Trạng thái'),
                  trailing: Text(widget.transaction.status!),
                ),
                ListTile(
                  title: Text('Hoa tiêu'),
                  trailing:
                      Text(widget.transaction.userTransaction?.name ?? 'Bạn'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    permission.contains("OWNER")
                        ? SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/transaction_detail_navigator',
                                  arguments: widget.transaction);
                            },
                            icon: Icon(Icons.info)),
                    permission.contains("OWNER")
                        ? IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                      context, '/transaction_detail',
                                      arguments: widget.transaction)
                                  .then((_) => {setState(() {})});
                            },
                            icon: Icon(Icons.edit))
                        : SizedBox.shrink(),
                    permission.contains("OWNER")
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Bạn có chắc chắn muốn xóa giao dịch này không?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Hủy')),
                                        TextButton(
                                            onPressed: () async {
                                              bool response =
                                                  await deleteTransaction(
                                                      widget.transaction.id!);
                                              if (response) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Xóa giao dịch thành công'),
                                                  backgroundColor: Colors.green,
                                                ));
                                                setState(() {
                                                  isDeleted = true;
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Xóa giao dịch thất bại'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }

                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Xóa')),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete))
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          );
  }
}
