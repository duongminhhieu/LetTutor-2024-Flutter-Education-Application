import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TutorTeacherCard extends StatefulWidget {
  final String? imageAsset;
  final String? name;
  final double? rating;
  final String? subtitle;
  final String? country;
  final bool? isFavorite;
  final List<String>? filterLabels; // Danh sách các nhãn cho FilterChips

  TutorTeacherCard({
     this.imageAsset,
     this.name,
     this.rating,
     this.subtitle,
      this.country,
     this.isFavorite,
     this.filterLabels, // Thêm danh sách nhãn
  });

  @override
  _TutorTeacherCardState createState() => _TutorTeacherCardState();
}

class _TutorTeacherCardState extends State<TutorTeacherCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
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
                      child: widget.imageAsset == null ? Image.network("https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1686033849227.jpeg") : 
                      Image.network(widget.imageAsset!),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                        color: _isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
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
                    widget.name ?? '',
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
                    SvgPicture.asset('lib/assets/images/vietnam.svg',
                        semanticsLabel: "My SVG", height: 20),
                    SizedBox(width: 5),
                     Text(
                     widget.country ?? "",
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
                    i < (widget.rating == null ? 0 : widget.rating!) ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 16,
                  ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.0,
                children: widget.filterLabels!.map((label) {
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
                widget.subtitle!,
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
            SizedBox(height: 32,),
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
                  SizedBox(width: 8), // Create a space between the icon and the text
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
}
