import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:src/data/model/schedule/schedule.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);
  final Schedule schedule;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade100, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 24),
              _buildCardInfo(),
              const SizedBox(height: 24),
              _buildCardTime(),
              const SizedBox(height: 16),
              _buildButton()
            ],
          ),
        ));
  }

  Widget _buildTitle() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child:  Text(
              formatDate(DateTime.fromMillisecondsSinceEpoch(widget.schedule!.startTimestamp!)),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '1 lesson',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // Danh sách tên thứ
    List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    // Danh sách tên tháng
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Lấy các thông tin về ngày, tháng, và năm từ DateTime
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year % 100;

    // Lấy tên thứ và tháng dựa vào index
    String dayOfWeek = daysOfWeek[dateTime.weekday - 1];
    String monthName = months[month - 1];

    // Tạo chuỗi định dạng
    String formattedDate = '$dayOfWeek, $day $monthName $year';

    return formattedDate;
  }

  Widget _buildCardInfo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset('lib/assets/images/loginImage.png'),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Keegan",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'lib/assets/images/vietnam.svg',
                      semanticsLabel: "My SVG",
                      height: 16,
                    ),
                    SizedBox(width: 5),
                    const Text(
                      'Vietnam',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.message_outlined,
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Container(
                        child: Text(
                      "Direct Message",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTime() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      "${widget.schedule!.startTime!} - ${widget.schedule!.endTime!}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.red),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.red),
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(2.0),
              side: BorderSide(
                  color: Colors.grey.shade100, width: 1.0),
            ),
            child: ExpansionTile(
              title: const Row(
                children: [
                  Expanded(
                      child: Text(
                    "Request for lesson",
                    style: TextStyle(fontSize: 14),
                  )),
                  Expanded(
                    child: TextButton(
                        onPressed: null,
                        child: Text(
                          "Edit Request",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        )),
                  )
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 24),
                  child: const Text(
                      "Currently there are no requests for this class. Please write down any requests for the teacher.",
                      style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(){
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.blue),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: const Text(
            'Go to meeting',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),
          )),
    );
  }
}
