import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mobile/services/appointment_service.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/widgets/car_card.dart';
import '../../model/time_busy_model.dart';

class CreateAppoint extends StatefulWidget {
  const CreateAppoint({super.key});

  @override
  State<CreateAppoint> createState() => _CreateAppointState();
}

class _CreateAppointState extends State<CreateAppoint> {
  Map<String, String> salonNameToId = {};
  late TextEditingController controller;
  ChatUserModel user = ChatUserModel(
    name: '',
    id: '',
  );
  DateTime today = DateTime.now();
  var hour = 0;
  var minute = 0;
  var timeFormat = 'AM';
  List<Car>? cars = [];
  String selectedCar = '';
  CarouselController carouselController = CarouselController();
  List<bool> isSelected = List.generate(16, (index) => false);
  late List<TimeBusyModel> timeBusy = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    Future.delayed(Duration.zero, () {
      getSalon();
      getCars().then((value) => getTimeBusy());
    });
  }

  Future<void> getTimeBusy() async {
    print('get time busy' + user.carId!);
    List<TimeBusyModel> timeBusyApi =
        await AppointmentService.getBusyCar(user.id, user.carId ?? '');
    setState(() {
      timeBusy = timeBusyApi;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  Future<void> getSalon() async {
    ChatUserModel userApi =
        ModalRoute.of(context)!.settings.arguments as ChatUserModel;
    setState(() {
      user = userApi;
    });
  }

  Future<void> getCars() async {
    List<Car>? carsApi = await SalonsService.getDetail(user.id);
    if (user.carId != '' && carsApi!.isNotEmpty) {
      int initialPage = carsApi.indexWhere((car) => car.id == user.carId);
      //print(initialPage);
      carouselController.animateToPage(initialPage);
      selectedCar = user.carId!;
    }
    setState(() {
      cars = carsApi;
      if (user.carId == '') {
        user.carId = cars![0].id;
      }
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //print(selectedDay);
    setState(() {
      today = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo lịch hẹn'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đặt lịch hẹn với salon ${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text(
                'Chọn ngày',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              Text(
                'Chọn giờ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    if (timeBusy.any((time) => time.time.hour == 7 + index && isSameDay(today,time.time))) {
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
                        color: timeBusy.any((time) => time.time.hour == 7 + index && isSameDay(today,time.time)) ? Colors.grey : Colors.transparent,
                        child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text((7 + index).toString() + ":00"),
                            ),
                      )),
                ),
              ),
              SizedBox(height: 10),
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: 450.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedCar = cars![index].id!;
                      });
                    }),
                items: cars!.length > 0
                    ? cars?.map((car) {
                        return CarCard(car: car);
                      }).toList()
                    : [],
              ),
              SizedBox(height: 10),
              Text(
                'Bạn đặt lịch hẹn để làm gì?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: controller,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    print(selectedCar);
                    DateTime combined = DateTime(
                        today.year, today.month, today.day, hour, minute);
                    print(combined);
                    var result = await AppointmentService.createAppointment(
                        AppointmentModel(
                      salon: user.id,
                      carId: selectedCar,
                      datetime: combined,
                      description: controller.text,
                    ));
                    print(result);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tạo lịch hẹn thành công'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pop(context);
                    }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Tạo lịch hẹn thất bại'),
                          backgroundColor: Colors.red,
                        ));
                        Navigator.pop(context);
                      }
                  },
                  child: Text('Tạo lịch hẹn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
