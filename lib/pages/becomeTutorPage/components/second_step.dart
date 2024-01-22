import 'package:flutter/material.dart';

import '../../../utilities/const.dart';

class SecondStep extends StatefulWidget {
  const SecondStep({super.key});

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  bool hasUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
                'Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality.',
               )),
        Row(children: [
          Expanded(child: Image.asset(ImagesPath.video, fit: BoxFit.contain)),
        ]),
        Visibility(
          visible: hasUploaded ? false : true,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text('Tips:',
                  )),
        ),
        Visibility(
          visible: hasUploaded ? false : true,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                  '1. Your video should last 1-3 minutes\n2. Smile and look at the camera\n3. Find a clear and quiet space\n4. Have fun!',
                  )),
        ),
        Visibility(
          visible: hasUploaded ? false : true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      color: Colors.grey.shade200),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Text('File_name.mp4',
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
        ),
        Row(
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
                  child: Text(
                    'Upload Video',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )),
          ],
        ),
      ],
    );
  }
}
