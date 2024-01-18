import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'package:src/providers/tutor_provider.dart';

import '../../../commons/dateSelection.dart';
import '../../../commons/timeRange.dart';
import '../../../utilities/const.dart';

class FilterComponent extends StatefulWidget {
  final Function(String, List<String>, Map<String, bool>) onSearch;

  const FilterComponent({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  TextEditingController tutorNameController = TextEditingController();

  // list of string options
  late List<String> specialities;
  List<String> nationalities = [
    'Foreign Tutor',
    'Vietnamese Tutor',
    'Native English Tutor'
  ];

  List<String> selectedNationalities = [];
  String selectedSpeciality = 'All';


  @override
  void initState() {
    specialities = ['All'];
    for (var element in Specialities.specialities) {
      specialities.add(element.name!);
    }
    for (var element in Specialities.topics) {
      specialities.add(element.name!);
    }
    super.initState();
  }

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
            child: Column(
              children: [
                Container(
                  child: Consumer<TutorProvider>(
                    builder: (BuildContext context, TutorProvider tutorProvider, Widget? child) {
                      return TextField(
                        controller: tutorNameController,
                        onChanged: (text){
                          widget.onSearch(text, convertSpeciality(selectedSpeciality), convertNation(selectedNationalities));
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
                const SizedBox(height: 12,),
                Container(
                  child: Consumer<TutorProvider>(
                    builder: (BuildContext context, TutorProvider tutorProvider, Widget? child) {
                      return Container(
                        width: double.infinity, // Set width to match parent
                        height: 42.0, // Set height to match TextInput
                        alignment: Alignment.center,
                        child: DropDownMultiSelect(
                          isDense: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40.0))),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(12),
                          ),
                          onChanged: (List<String> selected) {
                            setState(() {
                              widget.onSearch(tutorNameController.text, convertSpeciality(selectedSpeciality), convertNation(selected));
                            });
                          },
                          options: nationalities,
                          selectedValues: selectedNationalities,
                          whenEmpty: "Select tutor nationality",
                        ),
                      );
                    },
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
            child: Column(
              children: [
                Wrap(
                  spacing: 8.0, // Khoảng cách giữa các nút chọn
                  children: specialities.map((option) {
                    final isSelected = selectedSpeciality == option;
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
                                selectedSpeciality = option;
                                List<String> specialities = [];
                                specialities.add(option);

                                widget.onSearch(tutorNameController.text, convertSpeciality(selectedSpeciality), convertNation(selectedNationalities));
                              } else {
                                selectedSpeciality = 'All';
                                widget.onSearch(tutorNameController.text, [], convertNation(selectedNationalities));
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
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                onPressed: () {
                  tutorNameController.text = '';
                  selectedSpeciality = 'All';
                  selectedNationalities = [];
                  widget.onSearch('', convertSpeciality(selectedSpeciality), convertNation(selectedNationalities));
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
  
  Map<String, bool> convertNation(List<String> selectedNationalities) {
    Map<String, bool> result = {};
    for (var element in selectedNationalities) {
      if (element == 'Foreign Tutor') {
        result['isForeign'] = true;
      } else if (element == 'Vietnamese Tutor') {
        result['isVietnamese'] = true;
      } else if (element == 'Native English Tutor') {
        result['isNative'] = true;
      }
    }
    return result;
  }
  
  // convert speciality to list of string
  List<String> convertSpeciality(String selectedSpeciality) {
    List<String> result = [];
    if (selectedSpeciality == 'All') {
      return result;
    } else {
      result.add(selectedSpeciality.toLowerCase().replaceAll(' ', '-'));
      return result;
    }
  }
}

