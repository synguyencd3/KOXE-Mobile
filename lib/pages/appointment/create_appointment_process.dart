import 'package:flutter/material.dart';
import 'package:mobile/model/CarInvoice_response.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mobile/services/appointment_service.dart';

import '../../model/time_busy_model.dart';

class CreateAppointProcess extends StatefulWidget {
  const CreateAppointProcess({super.key});

  @override
  State<CreateAppointProcess> createState() => _CreateAppointProcessState();
}

class _CreateAppointProcessState extends State<CreateAppointProcess> {
  CarInvoice data = CarInvoice();
  DateTime today = DateTime.now();
  late final _description = TextEditingController();
  var hour = 0;
  var minute = 0;
  List<bool> isSelected = List.generate(16, (index) => false);
  late List<TimeBusyModel> timeBusy = [];
  double _titleSize = 20;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //print(selectedDay);
    setState(() {
      today = selectedDay;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getInvoice().then((value) => getTimeBusy());
    });
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  Future<void> getInvoice() async {
    CarInvoice dataAPI =
        ModalRoute.of(context)!.settings.arguments as CarInvoice;
    setState(() {
      data = dataAPI;
    });
  }

  Future<void> getTimeBusy() async {
    List<TimeBusyModel> timeBusyApi = await AppointmentService.getBusyCar(
        data.seller?.salonId ?? '', data.legalsUser?.carId ?? '');
    setState(() {
      timeBusy = timeBusyApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo lịch hẹn với khách hàng'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Thông tin khách hàng', style: TextStyle(fontSize: _titleSize, fontWeight: FontWeight.bold)),
              Text('Tên khách hàng: ${data.fullname}'),
              Text('Số điện thoại: ${data.phone}'),
              Text('Tên xe: ${data.carName}'),
              Text('Chọn ngày hẹn', style: TextStyle(fontSize: _titleSize, fontWeight: FontWeight.bold)),
              Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: today,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(day, today);
                    },
                    rowHeight: 43,
                    availableGestures: AvailableGestures.all,
                    onDaySelected: _onDaySelected,
                  )),
              const SizedBox(height: 10),
              Text('Chọn giờ',style: TextStyle(fontSize: _titleSize, fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    if (timeBusy.any((time) =>
                        time.time.hour == 7 + index &&
                        isSameDay(today, time.time))) {
                      return;
                    }
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                          setState(() {
                            hour = 7 + buttonIndex;
                          });
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  children: List<Widget>.generate(
                      16,
                      (index) => Container(
                            color: timeBusy.any((time) =>
                                    time.time.hour == 7 + index &&
                                    isSameDay(today, time.time))
                                ? Colors.grey
                                : Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text((7 + index).toString() + ":00"),
                            ),
                          )),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _description,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Lời nhắn cho khách hàng',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
                ),
                maxLines: 16,
                minLines: 6,
              ),
              TextButton(
                  onPressed: () async {
                    DateTime combined = DateTime(
                        today.year, today.month, today.day, hour, minute);
                    AppointmentModel appointment = AppointmentModel(
                        datetime: combined,
                        phone: data.phone,
                        carId: data.legalsUser!.carId!,
                        salon: data.seller!.salonId!,
                        description: _description.text);
                    bool response =
                        await AppointmentService.createAppointmentProcess(
                            appointment);
                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tạo lịch hẹn thành công'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tạo lịch hẹn thất bại'),
                        backgroundColor: Colors.red,
                      ));
                    }
                    {}
                  },
                  child: Text('Tạo lịch hẹn'))
            ],
          ),
        ),
      ),
    );
  }
}
