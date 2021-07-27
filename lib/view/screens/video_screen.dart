import 'package:flutter/material.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/data/model/exercise.dart';
import 'package:gohealth/view/components/atoms/video_container.dart';

class VideoScreen extends StatefulWidget {
  final Exercise exercise;
  VideoScreen(this.exercise);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool isFullScreen = false;
  String? author, title, duration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen ? null : AppBar(),
      body: Column(
        children: [
          VideoContainer(
            videoId: widget.exercise.videoId,
            onChange: (controller) {
              setState(() {
                isFullScreen = controller.value.isFullScreen;
                author = controller.metadata.author;
                title = controller.metadata.title;
                duration = controller.metadata.duration.inMinutes.toString();
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: TextStyles.title,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("author : $author"),
                  ],
                ),
                Row(
                  children: [
                    Text('duration : $duration mins'),
                  ],
                ),
                Row(
                  children: [Text('Description ')],
                ),
                Text('${widget.exercise.description}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
