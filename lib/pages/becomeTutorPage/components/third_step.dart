import 'package:flutter/material.dart';

import '../../../utilities/const.dart';

class ThirdStep extends StatefulWidget {
  const ThirdStep({super.key});

  @override
  State<ThirdStep> createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            ImagesPath.thanks,
            fit: BoxFit.contain,
            height: 200,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Thank you for joining LetTutor team. Please kindly wait for our approval process. The final result "
              "shall be sent through your email.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
//https://educity.app/flutter/how-to-pick-an-image-from-gallery-and-display-it-in-flutter
