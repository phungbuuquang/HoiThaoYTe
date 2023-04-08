import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/screens/lession/bloc/subject_bloc.dart';
import 'package:xcademy/screens/lession/pdf_screen.dart';
import 'package:xcademy/widgets/options_dialog.dart';
import 'package:xcademy/widgets/video/video_player_widget.dart';

class SubjectScreen extends StatefulWidget {
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late VideoPlayerController _controller;

  SubjectBloc get _bloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();

    // final url = Uri.encodeComponent(
    final url = _bloc.getUrl();
    print(url);
    _controller = VideoPlayerController.network(url);
    _controller.addListener(() {
      setState(() {});
      if (_controller.value.isInitialized) {
        _bloc.listenTimeCurrent(_controller);
      }
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) {
      _playVideo();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.getTotalPdf();
    });
  }

  _playVideo() async {
    await _bloc.getTimeCurrentVideo();
    _controller.seekTo(
      Duration(
        seconds: _bloc.seconds,
      ),
    );
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void deactivate() {
    _bloc.setTimeCurrentVideo();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyên đề'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayerWidget(
              controller: _controller,
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                (_bloc.subject.TieuDe ?? '').toUpperCase(),
                maxLines: null,
                style: AppTextStyle.semibold18Black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildNamePdfView(),
            SizedBox(
              height: 20,
            ),
            _buildNumPageView(),
            SizedBox(
              height: 20,
            ),
            _buildPdfView(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfView() {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (prev, curr) {
        return curr is SubjectGetUrlPdfState;
      },
      builder: (_, state) {
        if (state is SubjectGetUrlPdfState) {
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => PDFScreen(state.url),
              );
            },
            child: Image.network(
              state.url,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildNumPageView() {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (prev, curr) {
        return curr is SubjectGetNumPagePdfState;
      },
      builder: (_, state) {
        return Center(
          child: Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              border:
                  Border.all(color: ColorConstant.grayEAB.withOpacity(0.24)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _bloc.prevPage(),
                  icon: Icon(Icons.chevron_left),
                ),
                Text(
                  _bloc.totalPage == 0
                      ? '0/0'
                      : '${_bloc.currentPage + 1}/${_bloc.totalPage}',
                  style: AppTextStyle.medium14Black,
                ),
                IconButton(
                  onPressed: () => _bloc.nextPage(),
                  icon: Icon(Icons.chevron_right),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNamePdfView() {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (prev, curr) {
        return curr is SubjectGetNamePdfState;
      },
      builder: (_, state) {
        String name = '';
        if (state is SubjectGetNamePdfState) {
          name = state.name;
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final datas = _bloc.getListNamePdf();
            if (datas.isEmpty) {
              return;
            }
            showDialog(
              context: context,
              builder: (_) => OptionsDialog(
                title: 'Danh sách tài liệu',
                datas: datas,
                onSelect: (val) => _bloc.onChangePdf(val),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ColorConstant.grayEAB.withOpacity(0.24),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: AppTextStyle.regular14Gray,
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (context) {
        //       return [
        //         for (final speed in _examplePlaybackRates)
        //           PopupMenuItem(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
