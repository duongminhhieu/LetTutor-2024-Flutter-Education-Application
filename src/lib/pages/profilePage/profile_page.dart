import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'package:src/data/model/user/user.dart';
import 'package:src/pages/profilePage/components/birthday-select.dart';
import 'package:src/pages/profilePage/components/text-area.dart';
import 'package:src/providers/user_provider.dart';
import 'package:src/utilities/const.dart';
import '../../providers/auth_provider.dart';
import '../../utilities/validator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController studyScheduleController = TextEditingController();
  final countryController = TextEditingController();
  String selectedLevel = "Beginner";
  List<String> itemsCategory = [];
  List<String> selectedCategory = [];
  late DateTime selectedDate;
  late bool hasInitValue = false;
  XFile? _pickedFile;
  late bool _isLoading = false;

  Future<void> changeImage() async {
    // Show options for image source (camera or gallery)
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Capture Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  _captureImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    setState(() {
      _pickedFile = image;
    });
    if (_pickedFile != null) {
      // Update the profile picture with the new image URL
      // You may need to upload the image to a server and get the new URL
      // For simplicity, I'm using the local file path as the URL
      String newImageUrl = _pickedFile!.path;
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    setState(() {
      _pickedFile = image;
    });

    if (_pickedFile != null) {
      // Update the profile picture with the new image URL
      // You may need to upload the image to a server and get the new URL
      // For simplicity, I'm using the local file path as the URL
      String newImageUrl = _pickedFile!.path;
    }
  }

  void initValues(User userData) {
    setState(() {
      nameController.text = userData?.name ?? "";
      emailController.text = userData?.email ?? "";
      phoneController.text = userData?.phone ?? "";
      studyScheduleController.text = userData?.studySchedule ?? "";
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
    final authProvider = Provider.of<AuthProvider>(context);

    if (hasInitValue == false) {
      initValues(authProvider.currentUser!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1.0, color: Colors.grey.shade300),
              right: BorderSide(width: 1.0, color: Colors.grey.shade300),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _pickedFile != null
                                      ? FileImage(File(_pickedFile!.path))
                                          as ImageProvider<Object>
                                      : NetworkImage(authProvider
                                              .currentUser?.avatar ??
                                          "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              changeImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.blue.shade700,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      authProvider.currentUser?.name ?? "Anonymous",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                      child: _buildInfo(
                          "Account ID: ", authProvider.currentUser!.id! ?? "")),
                  SizedBox(height: 10),
                  Center(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        child: Text(
                      "Others review you",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )),
                  )),
                  SizedBox(height: 10),
                  Center(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )),
                  )),
                  SizedBox(height: 40),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  _buildForm(authProvider.currentUser!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(User userData) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildGreyText("Name"),
            const SizedBox(height: 8),
            _buildInputField(nameController, 'Enter your name', true,
                validator: Validator.validateName),
            const SizedBox(height: 16),
            _buildGreyText("Email Address"),
            const SizedBox(height: 8),
            _buildInputField(emailController, "Enter your email", false,
                validator: Validator.validateEmail),
            const SizedBox(height: 16),
            _buildGreyText("Country"),
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
                hintText: "Country",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16),
            _buildGreyText("Phone Number"),
            const SizedBox(height: 8),
            _buildInputField(phoneController, "Enter your phone", false,
                validator: Validator.validatePhoneNumber),
            const SizedBox(height: 16),
            _buildGreyText("Birthday"),
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
            _buildGreyText("My level"),
            const SizedBox(height: 8),
            _buildSelectLevel(
                "Choose your level", ConstValue.levelList, selectedLevel),
            const SizedBox(height: 16),
            _buildGreyText("Want to learn"),
            const SizedBox(height: 8),
            _buildSelect("Want to learn", itemsCategory),
            const SizedBox(height: 16),
            _buildGreyText("Study Schedule"),
            const SizedBox(height: 8),
            CustomTextArea(
                controller: studyScheduleController,
                hintText:
                    "Note the time of the week you want to study on LetTutor"),
            const SizedBox(height: 12),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });

        await handleSaveProfile();

        setState(() {
          _isLoading = false;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            // border radius
            borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color.fromRGBO(4, 104, 211, 1.0),
        minimumSize: const Size.fromHeight(46),
      ),
      child: !_isLoading
          ? Text(
              "Save changes",
              style: TextStyle(fontSize: 16),
            )
          : Container(
              height: 20,
              width: 20,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
          ),
    );
  }

  Widget _buildInfo(String title, String content) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Wrap(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
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

  Future<void> handleSaveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Update user info
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      User updatedUser = authProvider.currentUser!;
      updatedUser?.name = nameController.text;
      updatedUser?.email = emailController.text;
      updatedUser?.phone = phoneController.text;
      updatedUser?.country = countryController.text;
      updatedUser?.birthday =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      updatedUser?.level = selectedLevel.toUpperCase();
      updatedUser?.studySchedule = studyScheduleController.text;

      // Clear existing data
      updatedUser.learnTopics = [];
      updatedUser.testPreparations = [];

      for (var element in selectedCategory) {
        for (var speciality in Specialities.specialities) {
          if (speciality.name == element) {
            updatedUser.testPreparations?.add(speciality);
          }
        }

        for (var topic in Specialities.topics) {
          if (topic.name == element) {
            updatedUser.learnTopics?.add(topic);
          }
        }
      }

      if (_pickedFile != null) {
        userProvider.callAPIUpdateAvatar(
            authProvider,
            _pickedFile!.path,
            (userUpdate) => {
                  authProvider.saveLoginInfo(userUpdate, authProvider.token!),
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Update Avatar successful!.'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  )
                },
            (err) => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Update Avatar failed!: $err'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  )
                });
      }

      userProvider.callAPIUpdateProfile(
          authProvider,
          updatedUser,
          (updatedUser) => {
                authProvider.saveLoginInfo(updatedUser, authProvider.token!),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Update successful!.'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                )
              },
          (err) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Update failed!.'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                )
              });
    }
  }
}
