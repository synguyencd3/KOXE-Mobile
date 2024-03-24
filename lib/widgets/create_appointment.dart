import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mobile/widgets/dropdown.dart';

class CreateAppoint extends StatefulWidget {
  const CreateAppoint({super.key});

  @override
  State<CreateAppoint> createState() => _CreateAppointState();
}

class _CreateAppointState extends State<CreateAppoint> {
  DateTime today = DateTime.now();
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
  List<String> list = <String>['Chọn salon 1', 'Chọn salon 2', 'Chọn salon 3'];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      today = selectedDay;
    });
  }

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
            DropdownMenuExample(
              width: 300, // Giá trị chiều rộng
              valueNotifier: dropDownNotifier, // Đối tượng ValueNotifier
              items: list, // Danh sách các mục chuỗi
            ),
            SizedBox(height: 10),
            Text(
              'Chọn ngày',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
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
            Text(
              'Mô tả',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
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
