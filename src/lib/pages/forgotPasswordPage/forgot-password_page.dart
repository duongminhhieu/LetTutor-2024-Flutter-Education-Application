import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/UserProvider.dart';
import '../../utilities/validator.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SvgPicture.asset('lib/assets/images/lettutor_logo.svg',
            semanticsLabel: "My SVG", height: 36),
        actions: [
          MaterialButton(
            onPressed: () {},
            minWidth: 20,
            color: Colors.grey.shade300,
            textColor: Colors.white,
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
              child: SvgPicture.asset('lib/assets/images/vietnam.svg',
                  semanticsLabel: "My SVG", height: 18),
            ),
          )
        ],
      ),
      body: ListView(children: [
        Image.asset(
          'lib/assets/images/loginImage.png',
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildForm(),
        ),
      ]),
    );
  }

  Widget _buildForm() {
    var userProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Reset Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Please enter your email address to search for your account.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildGreyText("EMAIL"),
          const SizedBox(height: 8),
          _buildInputField(emailController, 'mail@example.com', validator: Validator.validateEmail),
          const SizedBox(height: 12),
          _buildResetButton(),
          const SizedBox(height: 24),
          _buildOtherLogin(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildPrimaryColorText(String text) {
    return Text(text,
        style: TextStyle(
            color: myColor, fontSize: 16, fontWeight: FontWeight.w400));
  }

  Widget _buildInputField(TextEditingController controller, String hintText,
      {isPassword = false, Function? validator}) {
    return TextFormField(
      validator: (value) {
        return validator!(value ?? "");
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(16),
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : null,
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          // Check login status
          if (userProvider.email == emailController.text) {
            // Login successful
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Your password: ${userProvider.password}'),
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
            Navigator.pushNamed(context, '/loginPage');
          } else {
            // Invalid credentials, show an error message or handle accordingly
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid email or password. Please try again.'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }

      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          // border radius
            borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color.fromRGBO(4, 104, 211, 1.0),
        minimumSize: const Size.fromHeight(52),
      ),
      child: const Text(
        "Send reset link",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or continue with"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tab(icon: SvgPicture.asset("lib/assets/images/facebook-logo.svg")),
              Tab(icon: SvgPicture.asset("lib/assets/images/google-logo.svg")),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: MaterialButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    minWidth: 32,
                    padding: const EdgeInsets.all(8),
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1, style: BorderStyle.solid, color: myColor)),
                    child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10), // Adjust the radius as needed
                        child: const Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                          size: 30,
                        )
                    )
                ),
              )],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signUpPage');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGreyText("Not a member yet?"),
                Text("Sign up",
                  style: TextStyle(
                      color: myColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/loginPage');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGreyText("Already have an account? "),
                Text("Login",
                    style: TextStyle(
                        color: myColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

