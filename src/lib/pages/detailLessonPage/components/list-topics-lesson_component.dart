import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ListTopicsLessonComponent extends StatefulWidget {
  const ListTopicsLessonComponent({Key? key}) : super(key: key);

  @override
  State<ListTopicsLessonComponent> createState() => _ListTopicsLessonComponentState();
}

class _ListTopicsLessonComponentState extends State<ListTopicsLessonComponent> {
  int selectedTopicIndex = 0;

  List<String> topics = [
    "1. The Internet",
    "2. AI",
    "3. Social Media",
    "4. Internet Privacy",
    "5. Live Streaming",
    "6. Coding",
    "7. Technology Transforming Healthcare",
  ];

  // Define a map that associates topic indices with their corresponding PDF asset paths.
  final Map<int, String> topicToPdfAsset = {
    0: "lib/assets/GiaoTrinhDanGuitar.pdf",
    1: "lib/assets/NoiLongNguoiDi.pdf", // Change to the actual asset path for AI.
    2: "lib/assets/GiaoTrinhDanGuitar.pdf", // Change to the actual asset path for Social Media.
    // Add more entries for other topics.
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListTopics(),
        SizedBox(height: 20),
        Divider(height: 1, thickness: 1, color: Colors.grey),
        SizedBox(height: 40),
        _buildPDFView(),
      ],
    );
  }

  Widget _buildListTopics() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.only(top: 32, bottom: 12),
          alignment: Alignment.centerLeft,
          child: const Text(
            "List topics",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (int index = 0; index < topics.length; index++)
          InkWell(
            onTap: () {
              setState(() {
                selectedTopicIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedTopicIndex == index ? Colors.blue : null,
              ),
              child: ListTile(
                title: Text(
                  topics[index],
                  style: TextStyle(
                    color: selectedTopicIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPDFView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      width: double.infinity,
      height: 500.0,
      child: SfPdfViewer.asset(
        // Load the PDF asset based on the selected topic index.
        topicToPdfAsset[selectedTopicIndex] ?? "lib/assets/GiaoTrinhDanGuitar.pdf",
        scrollDirection: PdfScrollDirection.horizontal,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
      ),
    );
  }
}

