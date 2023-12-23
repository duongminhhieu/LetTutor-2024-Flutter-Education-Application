import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/auth_provider.dart';
import 'package:src/providers/tutor_provider.dart';

import '../../../commons/dateSelection.dart';
import '../../../commons/timeRange.dart';

class FilterComponent extends StatefulWidget {
  const FilterComponent({Key? key}) : super(key: key);

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  TextEditingController tutorNameController = TextEditingController();
  TextEditingController tutorNationController = TextEditingController();
  String selectedFilter = 'All';

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
                    child: Consumer<TutorProvider>(
                      builder: (BuildContext context, TutorProvider tutorProvider, Widget? child) {
                        return TextField(
                          controller: tutorNameController,
                          onChanged: (text){
                            tutorProvider.searchTutor(filterStr: selectedFilter,tutorName: tutorNameController.text, tutorNation: tutorNationController.text);
                          },
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
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    child: Consumer<TutorProvider>(
                      builder: (BuildContext context, TutorProvider tutorProvider, Widget? child) {
                        return TextField(
                          controller: tutorNationController,
                          onChanged: (text){
                            tutorProvider.searchTutor(filterStr: selectedFilter,tutorName: tutorNameController.text, tutorNation: tutorNationController.text);
                          },
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
                        );
                      },
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
            child: FilterWidget(selectedFilter: selectedFilter, tutorNameController: tutorNameController, tutorNationController: tutorNationController),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                onPressed: () {
                  tutorNameController.text = '';
                  tutorNationController.text = '';
                  selectedFilter = 'All';
                },
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

  String selectedFilter;
  TextEditingController tutorNameController;
  TextEditingController tutorNationController;
  FilterWidget({super.key, required this.selectedFilter, required this.tutorNameController, required this.tutorNationController});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> filterOptions = [
    'All',
    'English-For-Kids',
    'Business-English',
    'TOEIC',
    'Conversational',
    "TOEFL"
    'PET',
    "KET",
    'IELTS',
    'TOEFL',
    "STARTERS",
    "MOVERS",
    "FLYERS",

    // add new filters
  ];


  @override
  Widget build(BuildContext context) {

   var authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Wrap(
          spacing: 8.0, // Khoảng cách giữa các nút chọn
          children: filterOptions.map((option) {
            final isSelected = widget.selectedFilter == option;
            return Consumer<TutorProvider>(
              builder: (BuildContext context, TutorProvider tutorProvider, Widget? child) {
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
                        widget.selectedFilter = option;
                        List<String> specialities = [];
                        specialities.add(option);
                        tutorProvider.callAPISearchTutor(1, widget.tutorNameController.text, specialities, authProvider);
                        //tutorProvider.searchTutor(filterStr: widget.selectedFilter, tutorName: widget.tutorNameController.text, tutorNation: widget.tutorNationController.text);
                      } else {
                        widget.selectedFilter = 'All';
                      }
                    });
                  },
                  selectedColor: Colors.blue.shade500,
                  checkmarkColor: Colors.white,
                );
              },

            );
          }).toList(),
        ),
      ],
    );
  }
}
