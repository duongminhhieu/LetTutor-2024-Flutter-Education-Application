import 'package:flutter/material.dart';
import 'package:src/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../data/model/courses/course.dart';

class ListTopicsLessonComponent extends StatefulWidget {
  const ListTopicsLessonComponent({Key? key, required this.course, required this.index}) : super(key: key);

  final Course course;
  final int index;

  @override
  State<ListTopicsLessonComponent> createState() => _ListTopicsLessonComponentState();
}

class _ListTopicsLessonComponentState extends State<ListTopicsLessonComponent> {
  int selectedTopicIndex = 0;
  @override
  void initState() {
    selectedTopicIndex = widget.index;
    // TODO: implement initState
    super.initState();
  }
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
          child:  Text(
            AppLocalizations.of(context)!.listOfTopic,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (int index = 0; index < widget.course.topics!.length; index++)
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
                  "${index + 1}. ${widget.course.topics?[index].name ?? "No title"}",
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
      height: 600.0,
      child: SfPdfViewer.network(
        widget.course.topics?[selectedTopicIndex].nameFile ?? "",
      )
    );
  }
}

