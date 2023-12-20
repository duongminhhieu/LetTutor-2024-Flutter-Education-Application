import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/tutor/tutor.dart';
import '../../../data/model/user/learn_topic.dart';
import '../../../data/model/user/test_preparation.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/tutor_provider.dart';
import '../../../utilities/const.dart';

class TutorTeacherCard extends StatefulWidget {
  final Tutor tutor;
  final bool isFavorite;
  final VoidCallback onClickFavorite;

  TutorTeacherCard(
      {required this.tutor,
      required this.isFavorite,
      required this.onClickFavorite});

  @override
  _TutorTeacherCardState createState() => _TutorTeacherCardState();
}

class _TutorTeacherCardState extends State<TutorTeacherCard> {
  late bool _isFavored;
  @override
  void initState() {
    super.initState();
    _isFavored = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    TutorProvider tutorProvider = context.watch<TutorProvider>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade100, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.tutor?.avatar ??
                            "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                              "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1700296337596.jpg");
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        tutorProvider.checkIfTutorIsFavored(widget.tutor!)
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color:
                            tutorProvider.checkIfTutorIsFavored(widget.tutor!)
                                ? Colors.red
                                : null,
                      ),
                      onPressed: () {
                        widget.onClickFavorite();
                        setState(() {
                          _isFavored = !_isFavored;
                        });
                      },
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.tutor.name ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    // SvgPicture.asset('lib/assets/images/vietnam.svg',
                    //     semanticsLabel: "My SVG", height: 20),
                    // SizedBox(width: 5),
                    Text(
                      widget.tutor.country ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < 5; i++)
                  Icon(
                    i < (widget.tutor.rating == null ? 0 : widget.tutor.rating!)
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow,
                    size: 16,
                  ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.0,
                children:
                    convertKeysToNames(widget.tutor.specialties!)!.map((label) {
                  return FilterChip(
                    backgroundColor: Colors.lightBlue.shade100,
                    label: Text(
                      label,
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.normal),
                    ),
                    onSelected: (bool selected) {
                      // Handle filter selection (if needed)
                    },
                    selected: false,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.tutor.bio!,
                textAlign: TextAlign.justify,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    height: 1.3),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/schedulePage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_card_rounded, // Use the book icon
                    color: Colors.blue, // Icon color
                  ),
                  SizedBox(
                      width: 8), // Create a space between the icon and the text
                  Text(
                    'Book',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> convertKeysToNames(String keys) {
    List<String> keyList = keys.split(',');
    List<String> result = [];

    for (String key in keyList) {
      for (TestPreparation speciality in Specialities.specialities) {
        if (key == speciality.key) {
          result.add(speciality.name!);
          break;
        }
      }

      for (LearnTopic topic in Specialities.topics) {
        if (key == topic.key) {
          result.add(topic.name!);
          break;
        }
      }
    }

    return result;
  }
}
