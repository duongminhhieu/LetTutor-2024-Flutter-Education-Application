import 'package:flutter/material.dart';

import '../../components/dateSelection.dart';
import '../../components/timeRange.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Find a tutor",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        hintText: 'Enter tutor name...',
                        hintStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade400),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        hintText: 'Select tutor nation',
                        hintStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade400),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Select available tutoring time:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                Container(
                  width: 280,
                  child: DateSelectionWidget(),
                ),
                SizedBox(height: 12),
                Container(
                  width: 280,
                  child: TimeRangeSelector(),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: FilterWidget(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1, style: BorderStyle.solid, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Reset Filters',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.blue),
                )),
          )
        ],
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> filterOptions = [
    'All',
    'English for Kids',
    'English for Business',
    'TOEIC',
    'PET',
    'IELTS',
    'TOEFL',
    // add new filters
  ];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0, // Khoảng cách giữa các nút chọn
          children: filterOptions.map((option) {
            final isSelected = selectedFilter == option;
            return FilterChip(
              backgroundColor: Colors.grey.shade300,
              label: Text(
                option,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              selected: isSelected,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedFilter = option;
                  } else {
                    selectedFilter = 'All';
                  }
                });
              },
              selectedColor: Colors.blue.shade500, // Màu nền khi chọn
              checkmarkColor: Colors.white, // Màu dấu check
            );
          }).toList(),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     // Thực hiện tìm kiếm hoặc xử lý dựa trên selectedFilter
        //     print('Selected Filter: $selectedFilter');
        //   },
        //   child: Text('Apply Filter'),
        // ),
      ],
    );
  }
}
