import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:src/pages/profilePage/components/birthday-select.dart';
import 'package:src/pages/profilePage/components/text-area.dart';

import '../../utilities/validator.dart';
import 'components/country-select.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController studyScheduleController = TextEditingController();
  // Define the list of countries
  List<String> countries = ['Vietnam', 'United States', 'Canada', 'Other'];
  String selectedCountry = "Vietnam";
  List<String> itemsLevel = [
    "Beginner",
    "Upper-Beginner",
    "Pre-Intermediate",
    "Intermediate",
    "Upper-Intermediate",
    "Pre-Advanced",
    "Advanced",
    "Very Advanced"
  ];
  List<String> itemsCategory = [
    "For Studying Abroad",
    "English for traveling",
    "STARTERS"
  ];
  List<String> selectedLevel = [];
  List<String> selectedCategory = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", textAlign: TextAlign.center,),
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
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.grey.shade300),
            right: BorderSide(width: 1.0, color: Colors.grey.shade300),
          ),
        ),
        child: SingleChildScrollView(

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
                                  color: Theme.of(context).scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg"))),

                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue.shade700,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Hieu Duong",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(child: _buildInfo("Account ID: ", "122222222222222222")),
                  SizedBox(height: 10),
                  Center(child: GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Text(
                        "Others review you",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue
                        ),
                    )),
                  )),
                  SizedBox(height: 10),
                  Center(child: GestureDetector(
                    onTap: (){},
                    child: Container(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue
                          ),
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
                  _buildForm(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildForm() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildGreyText("Name"),
            const SizedBox(height: 8),
            _buildInputField(nameController, 'Enter your name', validator: Validator.validateName),
            const SizedBox(height: 16),
            _buildGreyText("Email Address"),
            const SizedBox(height: 8),
            _buildInputField(emailController, "Enter your email", validator: Validator.validateEmail),
            const SizedBox(height: 16),
            _buildGreyText("Country"),
            const SizedBox(height: 8),
            CountrySelect(
              countries: countries,
              selectedCountry: selectedCountry,
              onCountryChanged: (String newCountry) {
                setState(() {
                  selectedCountry = newCountry;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildGreyText("Phone Number"),
            const SizedBox(height: 8),
            _buildInputField(phoneController, "Enter your phone", validator: Validator.validatePhoneNumber),
            const SizedBox(height: 16),
            _buildGreyText("Birthday"),
            const SizedBox(height: 8),
            BirthdayProfileSelect(),
            const SizedBox(height: 16),
            _buildGreyText("My level"),
            const SizedBox(height: 8),
            _buildSelect("Choose your level", itemsLevel, selectedLevel ),
            const SizedBox(height: 16),
            _buildGreyText("Want to learn"),
            const SizedBox(height: 8),
            _buildSelect("Want to learn", itemsCategory, selectedCategory ),
            const SizedBox(height: 16),
            _buildGreyText("Study Schedule"),
            const SizedBox(height: 8),
            CustomTextArea(controller: studyScheduleController, hintText: "Note the time of the week you want to study on LetTutor"),

            const SizedBox(height: 12),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          // border radius
            borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color.fromRGBO(4, 104, 211, 1.0),
        minimumSize: const Size.fromHeight(46),
      ),
      child: const Text(
        "Save changes",
        style: TextStyle(fontSize: 16),
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText,
      {isPassword = false, Function? validator}) {
    return TextFormField(
      validator: (value) {
        return validator!(value ?? "");
      },
      controller: controller,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
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

  Widget _buildSelect(
      String title, List<String> selects, List<String> selected) {
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
            selected = x;
          });
        },
        options: selects,
        selectedValues: selected,
        whenEmpty: title,
      ),
    );
  }

}
