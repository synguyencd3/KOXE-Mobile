
import 'package:flutter/material.dart';
import 'package:mobile/utils/utils.dart';

class TotalCard extends StatelessWidget {
  final String label;
  final int total;
  Color? color;
  TotalCard({super.key, required this.label, required this.total, this.color});

  @override
  Widget build(BuildContext context) {
    return   Card(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formatCurrency(total),
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label),
          ],
        ),
      ),
    );
  }
}
