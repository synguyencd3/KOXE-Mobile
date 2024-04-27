import 'package:flutter/material.dart';
import 'package:mobile/model/package_model.dart';

class PackageCard extends StatefulWidget {
  late PackageModel package;

  PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(widget.package.name),
          Text(widget.package.description),
          Text(widget.package.price.toString()),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
