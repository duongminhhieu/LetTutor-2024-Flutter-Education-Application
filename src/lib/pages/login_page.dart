import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset('lib/images/lettutor_logo.svg',
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
              child: SvgPicture.asset('lib/images/vietnam.svg',
                  semanticsLabel: "My SVG", height: 18),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(children: [
          Image.asset(
            'lib/images/loginImage.png',
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 10),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text(
                'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ))
            ],
          )
        ]),
      ),
    );
  }
}
