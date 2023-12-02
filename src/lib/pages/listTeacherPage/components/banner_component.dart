

import 'package:flutter/material.dart';

class BannerComponent extends StatelessWidget {
  final Color myColor;

  const BannerComponent({
    super.key,
    required this.myColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(7, 96, 191, 1.0),
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        children: [
          Container(
            child: const Text(
              'Upcoming lesson',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: const Text(
                    'Wed, 25 Oct 23 00:00 - 00:25 (starts in 11:02:11)',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 10),  // Adjusted this SizedBox
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/videoCallPage");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.ondemand_video,
                          color: myColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Enter lesson room",
                          style: TextStyle(
                            fontSize: 14,
                            color: myColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 16),
          Container(
            child: const Text(
              'Total lesson time is 509 hours 10 minutes',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

}
