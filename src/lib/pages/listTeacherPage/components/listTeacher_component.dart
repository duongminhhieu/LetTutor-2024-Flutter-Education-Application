import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/listTeacherPage/components/tutorTeacherCard.dart';
import 'package:src/providers/tutor_provider.dart';

class ListTeacherComponent extends StatefulWidget {
  const ListTeacherComponent({Key? key}) : super(key: key);

  @override
  State<ListTeacherComponent> createState() => _ListTeacherComponentState();
}

class _ListTeacherComponentState extends State<ListTeacherComponent> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TutorProvider>(
      builder: (BuildContext context, tutorProvider, Widget? child) {
        tutorProvider.getTutors(); // get mock data
        return Container(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Recommended Tutors',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tutorProvider.tutors.length,
                itemBuilder: (context, index) {
                  return TutorTeacherCard(
                    imageAsset:  tutorProvider.tutors[index].avatar,
                    name:  tutorProvider.tutors[index].name,
                    rating:  tutorProvider.tutors[index].rating,
                    subtitle:  tutorProvider.tutors[index].bio,
                    isFavorite: false,
                    filterLabels: convertStringToFilterLabels(tutorProvider.tutors[index].specialties),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  List<String> convertStringToFilterLabels(String inputString) {
    List<String> labels = inputString.split(',');

    // Một mapping giữa các từ khóa trong chuỗi và nhãn tương ứng
    Map<String, String> keywordToLabel = {
      'business-english': 'English for Business ',
      'conversational-english': 'English for Conversational',
      'english-for-kids': 'English for Kids',
      'ielts': 'IELTS',
      'starters': 'Starters',
      'movers': 'Movers',
      'flyers': 'Flyers',
      'ket': 'KET',
      'pet': 'PET',
      'toefl': 'TOEFL',
      'toeic': 'TOEIC',
    };

    List<String> filterLabels = labels.map((label) {
      return keywordToLabel[label] ?? label;
    }).toList();

    return filterLabels;
  }
}
