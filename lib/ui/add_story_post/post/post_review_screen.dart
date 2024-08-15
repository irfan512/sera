import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen_bloc.dart';
import '../../../util/app_strings.dart';
import '../../common/app_bar.dart';
import '../products_connect.dart';
import 'package:video_player/video_player.dart';

class PostReviewScreen extends StatelessWidget {
  static const String route = '/post_review_screen';
  final String path;
  const PostReviewScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final size = context.mediaSize;
    final bloc = context.read<AddStoryPostBloc>();
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        floatingActionButton: FloatingActionButton.small(
            elevation: 2.0,
            backgroundColor: theme.colorScheme.surface,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConnectProduct(imagePath: path)));
            },
            child: Icon(Icons.add, color: theme.colorScheme.onSurface)),
        appBar: CustomAppBar(
            isbottom: true,
            elevation: 0.0,
            backgroundColor: theme.colorScheme.onPrimary,
            iscenterTitle: true,
            title: Text(AppStrings.ADD_POST,
                style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios,
                    color: theme.colorScheme.secondary, size: 20)),
            onLeadingPressed: () => Navigator.pop(context)),
        body: Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
              height: size.height / 8.9,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                      controller: bloc.captionController,
                      maxLines: null,
                      style: textTheme.titleMedium,
                      decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          hintStyle: textTheme.titleSmall!.copyWith(
                              color: const Color(0xff888f7f),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                          border: InputBorder.none)))),
          path.isNotEmpty
              ? SizedBox(
                  height: size.height / 1.4,
                  width: size.width,
                  child: Image.file(File(path), fit: BoxFit.cover))
              : const SizedBox(),
          const SizedBox(height: 30)
        ]))));
  }
}

class VideoDetail extends StatefulWidget {
  final String videoUrl;
  const VideoDetail({super.key, required this.videoUrl});

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (File(widget.videoUrl).existsSync()) {
      _controller = VideoPlayerController.file(File(widget.videoUrl))
        ..addListener(() {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
          });
        })
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
        }).catchError((error) {
          log('Error initializing video: $error');
        });
    } else {
      log('Video file does not exist at path: ${widget.videoUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final size = context.mediaSize;
    final bloc = context.read<AddStoryPostBloc>();
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      floatingActionButton: FloatingActionButton.small(
          elevation: 2.0,
          backgroundColor: theme.colorScheme.surface,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConnectProduct(
                          videoPath: widget.videoUrl,
                        )));
          },
          child: Icon(Icons.add, color: theme.colorScheme.onSurface)),
      appBar: CustomAppBar(
          isbottom: true,
          elevation: 0.0,
          backgroundColor: theme.colorScheme.onPrimary,
          iscenterTitle: true,
          title: Text(AppStrings.ADD_POST,
              style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios,
                  color: theme.colorScheme.secondary, size: 20)),
          onLeadingPressed: () => Navigator.pop(context)),
      body: Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
        SizedBox(
            height: size.height / 8.9,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                    controller: bloc.captionController,
                    maxLines: null,
                    style: textTheme.titleMedium,
                    decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle: textTheme.titleSmall!.copyWith(
                            color: const Color(0xff888f7f),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        border: InputBorder.none)))),
        SizedBox(
          height: size.height / 1.4,
          width: size.width,
          child: Center(
            child: _isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                      _isPlaying
                          ? Container()
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 64.0,
                            ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller!.value.isPlaying
                                ? _controller!.pause()
                                : _controller!.play();
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
        const SizedBox(height: 30)
      ]))),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
