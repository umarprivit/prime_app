import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/controllers/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerDemoScreen extends StatefulWidget {
  const YouTubePlayerDemoScreen({super.key});

  @override
  State<YouTubePlayerDemoScreen> createState() =>
      _YouTubePlayerDemoScreenState();
}

class _YouTubePlayerDemoScreenState extends State<YouTubePlayerDemoScreen> {
  final VideoController con = Get.put(VideoController());
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    con.initializeDemoPlayer(Get.arguments['videoUrl']);

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
              title: Obx(
                () => Text(
                  con.topicName.value,
                  style: TextStyle(
                    fontFamily: Config.FONT_FAMILY,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
      body: Column(
        children: [
          YoutubePlayer(
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
          if (!isFullScreen) _buildPremiumMessage(context),
        ],
      ),
    );
  }

  Widget _buildPremiumMessage(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              "This is a demo video. Unlock the full course by purchasing Premium.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: Config.FONT_FAMILY,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Navigate to purchase screen
                Get.back();
              },
              child: const Text(
                "Get Premium",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    con.disposePlayer();
    super.dispose();
  }
}
