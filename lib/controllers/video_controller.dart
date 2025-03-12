import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  late YoutubePlayerController playerController;
  var isPlaying = false.obs;
  RxString videoUrl = ''.obs;
  RxString topicName = ''.obs;

  void initializePlayer() {
    String videoId = YoutubePlayer.convertUrlToId(videoUrl.value) ?? '';
    playerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    )..addListener(() {
        isPlaying.value = playerController.value.isPlaying;
      });
  }

  void disposePlayer() {}
}
