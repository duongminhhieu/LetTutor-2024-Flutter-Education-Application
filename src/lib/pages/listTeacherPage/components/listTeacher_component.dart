import 'package:flutter/material.dart';
import 'package:src/untils/tutorTeacherCard.dart';

class ListTeacherComponent extends StatefulWidget {
  const ListTeacherComponent({Key? key}) : super(key: key);

  @override
  State<ListTeacherComponent> createState() => _ListTeacherComponentState();
}

class _ListTeacherComponentState extends State<ListTeacherComponent> {
  final List<TutorTeacherData> teachers = [
    TutorTeacherData(
      imageAsset: 'lib/images/loginImage.png',
      name: 'John Doe',
      rating: 4.5,
      subtitle:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
      isFavorite: false,
      filterLabels: ['Math', 'Science', 'English'],
    ),
    TutorTeacherData(
      imageAsset: 'lib/images/loginImage.png',
      name: 'Jane Smith',
      rating: 4.8,
      subtitle:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
      isFavorite: true,
      filterLabels: ['History', 'Geography', 'English'],
    ),
    TutorTeacherData(
      imageAsset: 'lib/images/loginImage.png',
      name: 'Jane Smith',
      rating: 4.8,
      subtitle:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
      isFavorite: true,
      filterLabels: [
        'History',
        'Geography',
        'History',
        'Geography',
        'History',
        'Geography',
        'English'
      ],
    ),
    TutorTeacherData(
      imageAsset: 'lib/images/loginImage.png',
      name: 'Jane Smith',
      rating: 4.8,
      subtitle:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
      isFavorite: true,
      filterLabels: ['History', 'Geography', 'English'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
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
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              return TutorTeacherCard(
                imageAsset: teachers[index].imageAsset,
                name: teachers[index].name,
                rating: teachers[index].rating,
                subtitle: teachers[index].subtitle,
                isFavorite: teachers[index].isFavorite,
                filterLabels: teachers[index].filterLabels,
              );
            },
          )
        ],
      ),
    );
  }
}

class TutorTeacherData {
  final String imageAsset;
  final String name;
  final double rating;
  final String subtitle;
  final bool isFavorite;
  final List<String> filterLabels;

  TutorTeacherData({
    required this.imageAsset,
    required this.name,
    required this.rating,
    required this.subtitle,
    required this.isFavorite,
    required this.filterLabels,
  });
}
