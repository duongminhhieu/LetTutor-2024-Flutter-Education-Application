import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/commons/loading.dart';
import 'package:src/providers/user_provider.dart';
import 'package:src/utilities/validator.dart';

import '../../commons/loadingOverlay.dart';
import '../../data/model/user/user.dart';
import '../../data/model/user/user_data.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  // TODO: Add loading state
  bool hasAuthenticated = false;
  bool loading = true;

  // Check if user has previously logged in
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (!hasAuthenticated) {
      restorePreviousSession(authProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return loading ? const LoadingFilled() : _buildMainContent();
  }


  // build main content
  Widget _buildMainContent() {
    mediaSize = MediaQuery.of(context).size;
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
          Text(
            "Say hello to your English tutors",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: myColor, fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          const Text(
            "Become fluent faster through one on one video chat lessons tailored to your goals.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildGreyText("EMAIL"),
          const SizedBox(height: 8),
          _buildInputField(emailController, 'mail@example.com', validator: Validator.validateEmail),
          const SizedBox(height: 16),
          _buildGreyText("PASSWORD"),
          const SizedBox(height: 8),
          _buildInputField(passwordController, "Enter your password",
              isPassword: true, validator: Validator.validatePassword),
          const SizedBox(height: 12),
          GestureDetector(onTap:(){
            Navigator.pushNamed(context, '/forgotPasswordPage');
          },child: _buildPrimaryColorText('Forgot Password?')),
          const SizedBox(height: 12),
          _buildLoginButton(),
          const SizedBox(height: 16),
          if (userProvider.isRegistered)
            const Text(
              'Registration successful! Please log in.',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
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

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          var authProvider = Provider.of<AuthProvider>(context, listen: false);

          handleLoginByAccount(authProvider);
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
        "LOG IN",
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
            )
        ],
      ),
    );
  }

  void handleLoginByAccount(AuthProvider authProvider) async {
    LoadingOverlay.of(context).show();
    try {
      await authProvider.authRepository.loginByAccount(
          email: emailController.text,
          password: passwordController.text,
          onSuccess: (user, token) async {
            onLoginSuccess(user, token, authProvider);
          },
          onFail: (e) {
            onLoginFailed(e);
          });
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }



  Future<void> onLoginSuccess(
      User user, Tokens token, AuthProvider authProvider) async {
    authProvider.saveLoginInfo(user, token);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'refresh_token',
      authProvider.token?.refresh?.token ?? "",
    );

    Future.delayed(const Duration(seconds: 0), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
      Navigator.pushNamed(context, '/bottomNavBar');
    });
  }

  Future<void> onLoginFailed(Object error) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${error.toString()}'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> restorePreviousSession(AuthProvider authProvider) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token') ?? "";

      if (refreshToken.isNotEmpty) {
        await authProvider.authRepository.refreshToken(
          refreshToken: refreshToken,
          onSuccess: (user, token) async {
            authProvider.saveLoginInfo(user, token);

            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
              'refresh_token',
              authProvider.token!.refresh!.token!,
            );
            hasAuthenticated = true;
            if (mounted) {
              await Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/bottomNavBar');
              });
            }
          },
        );
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
