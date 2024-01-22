import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'package:src/data/model/user/user.dart';
import 'package:src/pages/becomeTutorPage/components/required_label.dart';
import 'package:src/utilities/validator.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../utilities/const.dart';
import '../../profilePage/components/birthday-select.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  final _formKey = GlobalKey<FormState>();
  final _txtName = TextEditingController();
  final countryController = TextEditingController();
  String selectedLevel = "Beginner";
  List<String> itemsCategory = [];
  late DateTime selectedDate;


  String? _txtLevel;
  bool hasUploaded = false;
  final List<DropdownMenuItem<String>> _levelList = [];
  late bool hasInitValue = false;
  late List<String> selectedCategory = [];

  void initValues(User userData) {
    setState(() {
      _txtName.text = userData?.name ?? "";
      countryController.text = userData?.country ?? "";
      if (userData?.birthday != null) {
        List<String> dateParts = userData!.birthday!.split('-');

        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);

          selectedDate = DateTime(year, month, day);
        } else {
          // Handle invalid date format
          selectedDate = DateTime.now();
        }
      } else {
        selectedDate = DateTime.now();
      }
      String level = userData?.level ?? "BEGINNER";
      for (var element in ConstValue.levelList) {
        if (element.toLowerCase().compareTo(level.toLowerCase()) == 0) {
          selectedLevel = element;
          break;
        }
      }
      for (var element in Specialities.specialities) {
        itemsCategory.add(element.name!);
      }
      for (var element in Specialities.topics) {
        itemsCategory.add(element.name!);
      }

      for (var element in userData?.learnTopics ?? []) {
        selectedCategory.add(element.name!);
      }
      for (var element in userData?.testPreparations ?? []) {
        selectedCategory.add(element.name!);
      }

      hasInitValue = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (hasInitValue == false) {
      initValues(authProvider.currentUser!);
    }

    return !hasInitValue
        ? const SizedBox()
        : Container(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 62,
                      foregroundImage: NetworkImage(authProvider.currentUser!.avatar ?? ""),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildGreyText(AppLocalizations.of(context)!.name),
                  const SizedBox(height: 8),
                  _buildInputField(_txtName,
                      AppLocalizations.of(context)!.enterYourName, true,
                      validator: Validator.validateName),
                  const SizedBox(height: 16),
                  _buildGreyText(AppLocalizations.of(context)!.country),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (Country country) {
                          countryController.text = country.name!;
                        },
                      );
                    },
                    controller: countryController,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey.shade400), // Set the color for disabled state
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: AppLocalizations.of(context)!.country,
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGreyText(AppLocalizations.of(context)!.birthday),
                  const SizedBox(height: 8),
                  BirthdayProfileSelect(
                    dateTimeData: selectedDate,
                    onBirthDayChanged: (String newBirthDay) {
                      setState(() {
                        selectedDate = DateTime.parse(newBirthDay);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildGreyText(AppLocalizations.of(context)!.myLevel),
                  const SizedBox(height: 8),
                  _buildSelectLevel(
                      "Choose your level", ConstValue.levelList, selectedLevel),
                  const SizedBox(height: 16),
                  _buildGreyText(AppLocalizations.of(context)!.specialities),
                  const SizedBox(height: 8),
                  _buildSelect(
                      AppLocalizations.of(context)!.specialities, itemsCategory),
                  const SizedBox(height: 16),
                  _buildGreyText("Introduction"),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey.shade400), // Set the color for disabled state
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintText:
                          'What the student will see first when they see your profile',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(12),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Certificates',
                      )),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                  ),
                                  color: Colors.grey.shade200),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  Text('Certificates.pdf',
                                     ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 18,
                                  )
                                ],
                              )),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16),
                                    foregroundColor: Colors.blue,
                                    backgroundColor: Colors.white,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.blue,
                                        )),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      hasUploaded = !hasUploaded;
                                    });
                                  },
                                  child: Text("Upload"),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: _buildGreyText(AppLocalizations.of(context)!.interests)),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey.shade400), // Set the color for disabled state
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintText:
                          'Write about your side-hobby like reading or traveling.',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(12),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.education,
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey.shade400), // Set the color for disabled state
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintText:
                          'Write about your achievements and education level.',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(12),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.experienceLevel,
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey.shade400), // Set the color for disabled state
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(12),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        'Current/Previous Profession',
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey.shade400), // Set the color for disabled state
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(12),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
  String formatDateStringFromApi(String? value) {
    if (value == null) return "";
    var values = value.split("-");
    return "${values[2]}/${values[1]}/${values[0]}";
  }
  String getDateString(DateTime value, String getType) {
    String dayOfWeek = DateFormat('EEEE').format(value);
    String dateNo = "$dayOfWeek, ${value.day}/${value.month}/${value.year}";
    String dateOnly = "${value.day}/${value.month}/${value.year}";
    String time = DateFormat.Hms().format(value);
    switch (getType) {
      case TimeFormat.getDateNo:
        return dateNo;
      case TimeFormat.getTime:
        return time;
      case TimeFormat.getDateAndTime:
        return "$dateNo - $time";
      case TimeFormat.getDateOnly:
        return dateOnly;
      default:
        return "$dateNo - $time";
    }
  }

  Widget _buildInputField(
      TextEditingController controller, String hintText, bool isEnable,
      {isPassword = false, Function? validator}) {
    return TextFormField(
      validator: (value) {
        return validator!(value ?? "");
      },
      enabled: isEnable,
      readOnly: !isEnable,
      controller: controller,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.shade400), // Set the color for disabled state
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(12),
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : null,
      ),
      obscureText: isPassword,
    );
  }
  Widget _buildSelectLevel(
      String title, List<String> selects, String selected) {
    return Container(
      width: double.infinity, // Set width to match parent
      height: 42.0, // Set height to match TextInput
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(8.0), // Match the TextInput border radius
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton<String>(
            underline: Container(),
            isDense: true,
            isExpanded: true,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            value: selected,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLevel = newValue;
                });
              }
            },
            items: ConstValue.levelList
                .map<DropdownMenuItem<String>>((String level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
          )),
    );
  }
  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
  Widget _buildSelect(String title, List<String> selects) {
    return Container(
      width: double.infinity, // Set width to match parent
      height: 42.0, // Set height to match TextInput
      alignment: Alignment.center,
      child: DropDownMultiSelect(
        isDense: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(12),
        ),
        onChanged: (List<String> x) {
          setState(() {
            selectedCategory = x;
          });
        },
        options: selects,
        selectedValues: selectedCategory,
        whenEmpty: title,
      ),
    );
  }
}
//https://educity.app/flutter/how-to-pick-an-image-from-gallery-and-display-it-in-flutter