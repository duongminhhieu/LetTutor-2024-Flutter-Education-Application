import 'package:chewie/chewie.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../data/model/tutor/tutor.dart';

class InfoComponent extends StatefulWidget {
  const InfoComponent({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  State<InfoComponent> createState() => _InfoComponentState();
}

class _InfoComponentState extends State<InfoComponent> {
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildMainInfo(),
          const SizedBox(height: 10),
          _buildTextDescription(),
          const SizedBox(height: 20),
          _buildIConAction(),
          const SizedBox(height: 20),
          _buildVideoInfo(),
          const SizedBox(height: 20),
          _buildOtherInfo(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      child: ExpandableText(
        widget.tutor.bio!,
        expandText: "More",
        collapseText: "Less",
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(widget.tutor.avatar!),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.tutor.name!,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i <
                              (widget.tutor.rating == null
                                  ? 0
                                  : widget.tutor.rating!)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    '(${widget.tutor.feedbacks?.length!})',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'lib/assets/images/vietnam.svg',
                    semanticsLabel: "My SVG",
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.tutor.country!,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildIConAction() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Handle the favorite icon tap
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Column(
              children: [
                Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.red,
                  size: 24,
                ),
                Container(
                  child: const Text(
                    "Favorite",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 20),
          Column(
            children: [
              const Icon(
                Icons.report_gmailerrorred,
                color: Colors.blue,
                size: 24,
              ),
              Container(
                child: const Text(
                  "Report",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ChewieDemo(tutor: widget.tutor)],
      ),
    );
  }

  Widget _buildOtherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Education",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.tutor.education!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Languages",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: convertStringToLanguages(widget.tutor.languages)!
                        .map((label) {
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
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Specialties",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children:
                        convertStringToSpecialties(widget.tutor.specialties)!
                            .map((label) {
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
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Interests",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.tutor.interests!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Teaching experience",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.tutor.experience!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  List<String>? convertStringToSpecialties(String? inputString) {
    List<String>? labels = inputString?.split(',');

    // Một mapping giữa các từ khóa trong chuỗi và nhãn tương ứng
    Map<String, String> keywordToLabel = {
      'business-english': 'English for Business',
      'conversational-english': 'Conversational',
      'english-for-kids': 'English for Kids',
      'ielts': 'IELTS',
      'starters': 'STARTERS',
      'movers': 'MOVERS',
      'flyers': 'FLYERS',
      'ket': 'KET',
      'pet': 'PET',
      'toefl': 'TOEFL',
      'toeic': 'TOEIC',
    };

    List<String>? filterLabels = labels?.map((label) {
      return keywordToLabel[label] ?? label;
    }).toList();

    return filterLabels;
  }

  List<String>? convertStringToLanguages(String? inputString) {
    List<String>? labels = inputString?.split(' ');

    return labels;
  }
}

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
    required this.tutor,
  }) : super(key: key);

  final String title;
  final Tutor tutor;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.tutor.video!));
    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      hideControlsTimer: const Duration(seconds: 1),

      showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController.pause();
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Container(
            height: 280,
            child: Chewie(
                controller: _chewieController!,
              ),
          )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
