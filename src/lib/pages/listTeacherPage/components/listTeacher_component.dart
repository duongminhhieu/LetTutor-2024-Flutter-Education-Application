import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/listTeacherPage/components/tutorTeacherCard.dart';
import 'package:src/providers/tutor_provider.dart';

import '../../../providers/auth_provider.dart';
import '../../detailATeacherPage/detail-a-teacher_page.dart';

class ListTeacherComponent extends StatefulWidget {
  const ListTeacherComponent({Key? key}) : super(key: key);

  @override
  State<ListTeacherComponent> createState() => _ListTeacherComponentState();
}

class _ListTeacherComponentState extends State<ListTeacherComponent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TutorProvider tutorProvider = context.watch<TutorProvider>();
    var authProvider = Provider.of<AuthProvider>(context);

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
              return GestureDetector(
                onTap: () {
                  debugPrint("Tutor info: " +
                      tutorProvider.tutors[index].name.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailATeacherPage(),
                      settings:
                          RouteSettings(arguments: tutorProvider.tutors[index]),
                    ),
                  );
                },
                child: TutorTeacherCard(
                  tutor: tutorProvider.tutors[index],
                  isFavorite: tutorProvider
                      .checkIfTutorIsFavored(tutorProvider.tutors[index]),
                  onClickFavorite: () {
                    tutorProvider.callApiManageFavoriteTutor(
                        tutorProvider.tutors[index], authProvider, index,
                        (message, unfavored) async {
                      setState(() {
                        if (unfavored) {
                          tutorProvider.favTutorSecondId
                              .remove(tutorProvider.tutors[index].userId);
                        } else {
                          tutorProvider.favTutorSecondId
                              .add(tutorProvider.tutors[index].userId!);
                          tutorProvider.favTutorSecondId =
                              tutorProvider.favTutorSecondId.toSet().toList();
                        }
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }, (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
