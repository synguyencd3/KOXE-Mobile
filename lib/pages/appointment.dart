import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/appointment_card.dart';
import '../widgets/create_appointment.dart';
import 'package:mobile/services/appointment_service.dart';
import 'package:mobile/model/appointment_model.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Lịch hẹn'),
    Tab(text: 'Lịch sử'),
    Tab(text: 'Tạo lịch hẹn')
  ];
  List<AppointmentModel> appointmentsCurrent = [];
  List<AppointmentModel> appointmentsHistory = [];
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    getAllAppointments();
    _tabController.addListener(() {
      // Check if the 'Lịch hẹn' tab is selected
      if (_tabController.index == 0) {
        // Call setState to rebuild the widget
          getAllAppointments();
      }
    });
  }

  Future<void> getAllAppointments() async {
    try {
      List<AppointmentModel> appointmentAPI = await AppointmentService.getAll();
      print(appointmentAPI[0].datetime);
      setState(() {
        appointmentsCurrent = [];
        appointmentsHistory = [];
        for (var appointment in appointmentAPI) {
          int daysDifference = DateTime.parse(appointment.datetime).difference(DateTime.now()).inDays;
          if (daysDifference > 0) {
            appointmentsCurrent.add(appointment);
          } else {
            appointmentsHistory.add(appointment);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TabBar(
            tabs: tabs,
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                appointmentsCurrent.isEmpty
                    ? Center(
                        child: Text('Bạn không có cuộc hẹn nào',
                            style: TextStyle(fontSize: 20)),
                      )
                    : ListView.builder(
                        itemCount: appointmentsCurrent.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 1),
                        itemBuilder: (context, index) {
                          return AppointmentCard(
                              appointment: appointmentsCurrent[index]);
                        },
                      ),
                ListView.builder(
                  itemCount: appointmentsHistory.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                    return AppointmentCard(appointment: appointmentsHistory[index]);
                  },
                ),
                CreateAppoint(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
