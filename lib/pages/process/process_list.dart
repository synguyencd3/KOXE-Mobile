import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/process_model.dart';
import '../loading.dart';

class Processes extends StatefulWidget {
  const Processes({super.key});

  @override
  State<Processes> createState() => _ProcessesState();
}

class _ProcessesState extends State<Processes> {
  List<process> processes = [];
  bool isCalling = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProcesses();
  }

  Future<void> deleteProcess(String id) async {
    ProcessService.DeleteProcess(id).then((value) {getProcesses();});
  }

  void getProcesses() async {
    var data = await ProcessService.getAll();
    setState(() {
      processes = data;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: () {
              Navigator.pushNamed(context, '/new_process').then((value) {getProcesses();});
            }, child: Text('New Process')),
          ),
          Expanded(
              child: processes.isEmpty && !isCalling ? Loading(): ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: processes.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(10),
                        child: ProcessCard(processModel: processes[index], delete: deleteProcess,));
                  })),
          ],
      ),
    );
  }
}

class ProcessCard extends StatelessWidget {
  const ProcessCard({super.key, required this.processModel, required this.delete});
  final process processModel;

  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(12),
        child: Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Column(
            children: [
              Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Text(
                      '${processModel.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              Align(
                  alignment: AlignmentDirectional(-1,0),
                  child: Text(processModel.description!)),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(onPressed: () {
                      Navigator.pushNamed(context, '/new_process', arguments: {'process': process});
                    }, child: Text('Edit')),
                    OutlinedButton(onPressed: () {
                      delete(processModel.id);
                    }, child: Text('Delete')),
                  ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}

