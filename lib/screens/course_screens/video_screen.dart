import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/chapter_controller.dart';
import 'package:prime_app/controllers/video_controller.dart';
import 'package:prime_app/widgets/dashboard_widgets/library_container.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  const YouTubePlayerScreen({super.key});

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  final VideoController con = Get.find<VideoController>();
  final ChapterController con1 = Get.put(ChapterController());

  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    con.initializePlayer();

    // Listen for fullscreen changes
    con.playerController.addListener(() {
      if (con.playerController.value.isFullScreen != isFullScreen) {
        setState(() {
          isFullScreen = con.playerController.value.isFullScreen;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
          ? null
          : AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  con.disposePlayer();
                  Get.back();
                },
              ),
              title: Text(
                con.topicName.value,
                style: TextStyle(
                  fontFamily: Config.FONT_FAMILY,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: const DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: con.playerController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Theme.of(context).primaryColor,
            progressColors: ProgressBarColors(
              playedColor: Theme.of(context).primaryColor,
              handleColor: Theme.of(context).primaryColor,
            ),
            onEnded: (metaData) {
              con.playerController.seekTo(const Duration(seconds: 0));
            },
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
                if (!isFullScreen) _buildControls(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              // Ask a Question Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Ask a Question",
                      style: TextStyle(
                        fontFamily: Config.FONT_FAMILY,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Clipboard Button
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.content_paste_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Notes Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Notes",
                      style: TextStyle(
                        fontFamily: Config.FONT_FAMILY,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ...con1.classList.map((e) {
            return LibraryContainer(
              label: "${e['name']}",
              onTap: () {},
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    con.disposePlayer();
    super.dispose();
  }
}
