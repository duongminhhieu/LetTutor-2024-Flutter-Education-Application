import 'package:flutter/material.dart';

import '../../commons/appBar.dart';
import '../../l10n/app_localizations.dart';
import 'components/first_step.dart';
import 'components/second_step.dart';
import 'components/third_step.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({Key? key}) : super(key: key);

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.becomeATutor,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 1) {
            setState(() {
              _index += 1;
            });
          } else {
            setState(() {
              _index -= 1;
            });
          }
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _index == 2;
          return Container(
              margin: const EdgeInsets.fromLTRB(0, 24, 0, 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (_index == 1)
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 120),
                        child: ElevatedButton(
                          onPressed: details.onStepCancel ?? () {},
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    if (_index == 1)
                      const SizedBox(
                        width: 24,
                      ),
                    if (!isLastStep)
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 120),
                        child: ElevatedButton(
                          onPressed: details.onStepContinue ?? () {},
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                  ]));
        },
        steps: <Step>[
          Step(
              state: _index > 2 ? StepState.complete : StepState.indexed,
              title: const Text('Step 1: Complete your profile'),
              content: const FirstStep(),
              isActive: _index >= 0),
          Step(
              state: _index > 2 ? StepState.complete : StepState.indexed,
              title: const Text('Step 2: Video introduction'),
              content: const SecondStep(),
              isActive: _index >= 1),
          Step(
              title: const Text('Step 3: Approval'),
              content: const ThirdStep(),
              isActive: _index >= 2),
        ],
      ),
    );
  }
}
