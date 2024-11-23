import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_material/utils/global.dart';
import 'package:study_material/utils/kstyles.dart';

import '../../../../utils/app_colors.dart';
import '../controllers/course_detail_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class ModuleDetails extends GetView<CourseDetailController> {
  const ModuleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        title: Kstyles().med(text: 'Module Details', size: 18),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: controller.videosList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final videoUrl =
                          controller.videosList[index].videoUrl ?? "";

                      if (videoUrl.contains('youtube.com') ||
                          videoUrl.contains('youtu.be')) {
                        return YouTubeVideoPlayer(videoUrl: videoUrl);
                      } else if (videoUrl.contains('vimeo.com')) {
                        return VimeoVideoPlayer(videoUrl: videoUrl);
                      } else {
                        return Center(
                          child: Kstyles().reg(
                            text: 'Unsupported video format',
                            size: 15,
                          ),
                        );
                      }
                    },
                  ),
                ),
                10.height,
                Kstyles().semiBold(
                    text: controller.videosList[index].title ?? "", size: 16),
                Kstyles().light(
                  text: controller.videosList[index].description ?? "",
                  size: 12,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class YouTubeVideoPlayer extends StatelessWidget {
  final String videoUrl;

  const YouTubeVideoPlayer({required this.videoUrl, super.key});
  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? "";
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
          enableCaption: false,
        ),
      ),
      showVideoProgressIndicator: true,
      aspectRatio: 16 / 9,
      width: double.infinity,
    );
  }
}

class VimeoVideoPlayer extends StatelessWidget {
  final String videoUrl;

  const VimeoVideoPlayer({required this.videoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final videoId = _extractVimeoVideoId(videoUrl);

    if (videoId == null) {
      return Center(
        child: Kstyles().semiBold(text: 'Invalid Vimeo URL', size: 16),
      );
    }

    return VimeoPlayer(
      videoId: videoId,
    );
  }

  String? _extractVimeoVideoId(String url) {
    final regex = RegExp(r'vimeo\.com/(?:video/|)(\d+)');
    final match = regex.firstMatch(url);
    return match?.group(1);
  }
}
