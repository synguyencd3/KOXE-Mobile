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
with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Lịch hẹn'),
    Tab(text: 'Lịch sử'),
    Tab(text: 'Tạo lịch hẹn')
  ];
  List<AppointmentModel> appointments = [];
  late final TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    getAllAppointments();
  }
  Future<void> getAllAppointments() async {
    try {
      List<AppointmentModel> appointmentAPI = await AppointmentService.getAll();
      setState(() {
        appointments = appointmentAPI;
      });
      print(appointmentAPI[0].datetime);
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
          TabBar(tabs: tabs,controller: _tabController,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: appointments.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                   return AppointmentCard(appointment: appointments[index]);
                  },
                ),
                ListView.builder(
                  itemCount: 16,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                    return AppointmentCard(appointment: appointments[index]);
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
