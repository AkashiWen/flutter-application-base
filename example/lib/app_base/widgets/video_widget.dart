import 'package:example/app_base/app_base.dart';
import 'package:example/app_base/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

enum PlayerStatus {
  /// 播放
  play,

  /// 暫停
  pause,

  /// 播放完成
  completed
}

/// 視頻播放器widget
class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.url,
    required this.title,
    this.playerStatusListener,
    this.background,
    this.controller,
    this.fullScreenListener,
    this.progressListener,
    this.seekTo,
    this.onBack,
  }) : super(key: key);

  /// 視頻地址
  final String url;

  /// 視頻播放進度
  final num? seekTo;

  /// 視頻標題
  final String title;

  /// 背景顏色
  final Color? background;

  /// video controller
  final VideoPlayerController? controller;

  /// 0/1: 播放/暫停 2: 播放完成
  final Function(PlayerStatus playerStatus)? playerStatusListener;

  /// 進度監聽
  final Function(int progress)? progressListener;

  /// 全屏監聽
  final Function(bool isFullScreen)? fullScreenListener;

  /// 返回
  final Function? onBack;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Color _background;

  bool _isFullScreen = false;
  bool _isPlaying = false;
  bool _showLayer = true;
  bool _isCompleted = false;

  late double _screenWidth;
  late double _screenHeight;

  num _currentSeconds = 0;

  @override
  void initState() {
    super.initState();
    _background = widget.background ?? Colors.white;
    _controller = widget.controller ?? VideoPlayerController.network(widget.url)
      ..addListener(() {
        // 播放狀態改變
        bool isPlaying = _controller.value.isPlaying;
        if (_isPlaying != isPlaying) {
          _isPlaying = isPlaying;
          widget.playerStatusListener?.call(
            _isPlaying ? PlayerStatus.play : PlayerStatus.pause,
          );
          setState(() {});
        }

        int seconds = _controller.value.position.inSeconds;
        if (_currentSeconds != seconds) {
          _currentSeconds = seconds;
          widget.progressListener?.call(seconds);
          setState(() {});
        }

        // 是否播放完畢
        if (!_isCompleted &&
            _controller.value.position.inSeconds ==
                _controller.value.duration.inSeconds) {
          widget.playerStatusListener?.call(PlayerStatus.completed);
          _isPlaying = false;
          _isCompleted = true;
          setState(() {});
        }
      })
      ..initialize().then((_) {
        _currentSeconds = widget.seekTo ?? 0;
        _controller.seekTo(Duration(seconds: _currentSeconds.toInt()));
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 恢復狀態欄
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    _screenWidth = queryData.size.width;
    _screenHeight = queryData.size.height;
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _isFullScreen
                ? _screenWidth / _screenHeight
                : _controller.value.aspectRatio,
            child: Stack(children: [
              /// video player 組件
              VideoPlayer(_controller),

              /// 背景
              InkWell(
                onTap: () => setState(() {
                  _showLayer = !_showLayer;
                }),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),

              /// 左上角返回按鈕和標題
              _showLayer
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              widget.onBack?.call();
                            },
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.w,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Offstage(),

              /// 在中間顯示播放/暫停按鈕
              _showLayer
                  ? Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 48,
                        ),
                        onPressed: () {
                          _isCompleted = false;
                          _isPlaying ? _controller.pause() : _controller.play();
                          setState(() {});
                        },
                      ),
                    )
                  : const Offstage(),

              /// 右下角全屏按鈕
              _showLayer
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          // 橫豎屏切換
                          _isFullScreen = !_isFullScreen;
                          if (_isFullScreen) {
                            // 隱藏狀態欄
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.leanBack);
                            // 橫屏
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                            ]);
                          } else {
                            // 恢復狀態欄
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: SystemUiOverlay.values);
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                          }
                          widget.fullScreenListener?.call(_isFullScreen);
                          setState(() {});
                        },
                      ),
                    )
                  : const Offstage(),

              /// 底部視頻進度條
              _showLayer
                  ? Positioned(
                      bottom: _isFullScreen ? 10.w : 16.h,
                      child: SizedBox(
                        height: 10.h,
                        width: _screenWidth - 32.w,
                        child: Slider(
                          thumbColor: AColors.ff13a07b,
                          activeColor: AColors.ff13a07b,
                          inactiveColor: AColors.ff13a07b.withOpacity(0.5),
                          value: _currentSeconds.toDouble(),
                          min: 0.0,
                          max: _controller.value.duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            // _currentSeconds = value;
                            // setState(() {
                            //   _controller
                            //       .seekTo(Duration(seconds: value.toInt()));
                            // });
                          },
                        ),
                      ),
                    )
                  : const Offstage(),
            ]),
          )
        : Container(
            color: _background,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AColors.ff0f9b72),
              ),
            ),
          );
  }
}
