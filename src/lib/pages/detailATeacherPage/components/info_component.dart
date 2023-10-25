import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InfoComponent extends StatefulWidget {
  const InfoComponent({Key? key, required this.filterLabels}) : super(key: key);
  final List<String> filterLabels;
  @override
  State<InfoComponent> createState() => _InfoComponentState();
}

class _InfoComponentState extends State<InfoComponent> {
  final videoUrl = "https://www.youtube.com/watch?v=rQx0fKQdUgM";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        ],
      ),
    );
  }

  Widget _buildTextDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const ExpandableText(
        'I am passionate about running and fitness, I often compete in trail mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
        expandText: "More",
        textAlign: TextAlign.justify,
        style: TextStyle(
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
            child: Image.asset('lib/images/loginImage.png'),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Hieu Duong",
                style: TextStyle(
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
                      i < 3.5 ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  const SizedBox(width: 4),
                  const Text(
                    '(125)',
                    style: TextStyle(
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
                    'lib/images/vietnam.svg',
                    semanticsLabel: "My SVG",
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  const Text(
                    'Viet nam',
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
          Column(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.red,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () => debugPrint('Ready'),
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent
              ),
            ),
            const PlaybackSpeedButton(),
            FullScreenButton(),

          ],
        )
      ],
    );
  }

  Widget _buildOtherInfo(){
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
                  child: const Text("Education", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("VNU-University", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                  ),),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Languages", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: widget.filterLabels.map((label) {
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
                  child: const Text("Specialties", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: widget.filterLabels.map((label) {
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
                  child: const Text("Interests", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("I loved the weather, the scenery and the laid-back lifestyle of the locals.", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                  ),),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Teaching experience", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("I have more than 10 years of teaching english experience", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                  ),),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

}
