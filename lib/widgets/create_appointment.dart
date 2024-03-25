import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateAppoint extends StatefulWidget {
  const CreateAppoint({super.key});

  @override
  State<CreateAppoint> createState() => _CreateAppointState();
}

class _CreateAppointState extends State<CreateAppoint> {
  List<Salon> salons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSalons();
  }

  Future<void> getSalons() async {
    var list = await SalonsService.getAll();
    print(list);
    setState(() {
      salons = list;
    });
  }

  DateTime today = DateTime.now();
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
  List<String> list = <String>['Chọn salon 1', 'Chọn salon 2', 'Chọn salon 3'];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      today = selectedDay;
    });
  }

  var hour = 0;
  var minute = 0;
  var timeFormat = 'AM';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn salon',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 10),
            salons.isEmpty
                ? CircularProgressIndicator() // Show loading indicator while fetching data
                : DropdownMenuExample(
                    width: 300, // Giá trị chiều rộng
                    valueNotifier: dropDownNotifier, // Đối tượng ValueNotifier
                    items: salons
                        .map((salon) => salon.name!)
                        .toList(), // Danh sách các mục chuỗi
                  ),
            SizedBox(height: 10),
            Text(
              'Chọn ngày',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 10),
            Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
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
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberPicker(
                    minValue: 0,
                    maxValue: 12,
                    value: hour,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        hour = value;
                      });
                    },
                    textStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),

                  // Add a NumberPicker for minutes
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: minute,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: (value) {
                      setState(() {
                        minute = value;
                      });
                    },
                    textStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = 'AM';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              color: timeFormat=='AM' ? Colors.grey.shade500 : Colors.grey.shade800,
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            'AM',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = 'PM';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              color: timeFormat=='PM' ? Colors.grey.shade500 : Colors.grey.shade800,
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            'PM',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Mô tả',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 10),
            TextField(
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Tạo lịch hẹn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
