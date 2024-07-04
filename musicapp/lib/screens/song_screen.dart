import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class SongScreen extends StatefulWidget {
  final String title;
  final String artist;
  final String audioUrl;
  final String imageUrl;
  final bool favorite ;
  final Function(String, String, String, String) onFavoritePressed;
  final Function(String) removeFromFavorites;

  const SongScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.audioUrl,
    required this.imageUrl,
    required this.onFavoritePressed,
    required this.removeFromFavorites , 
    required this. favorite  ,
    
  });

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final player = AudioPlayer();
  bool loaded = false;
  bool isPlaying = false;
  bool isFavorite = false;


  @override
  void initState() {
    super.initState();
    isFavorite = widget.favorite;
    loadMusic();
  }



  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void loadMusic() async {
    await player.setAudioSource(
      AudioSource.uri(Uri.parse(widget.audioUrl)),
    );
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      isPlaying = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      isPlaying = false;
    });
    await player.pause();
  }

 

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      widget.onFavoritePressed(
          widget.title, widget.artist, widget.audioUrl, widget.imageUrl);
    } else {
       widget.removeFromFavorites(widget.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Player",
          style: TextStyle(
              color: Color(0XFF83C5BE), fontSize: 35, fontFamily: 'JotiOne'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Text(
                'Listening To',
                style: TextStyle(fontSize: 22, fontFamily: 'JotiOne'),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF83C5BE),
                      Color(0xFF83C5BE),
                      Color(0XFFFFDDD2)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: ClipOval(
                  child: Container(
                    width: 260.0,
                    height: 260.0,
                    child: Image.asset(
                      widget.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'JotiOne',
                      fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : null,
                  ),
                  onPressed: () {
                    toggleFavorite();
                  },
                ),
              ],
            ),
            Text(
              widget.artist,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 129, 129, 129),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: StreamBuilder<Duration?>(
                stream: player.durationStream,
                builder: (context, snapshot1) {
                  final duration = snapshot1.data ?? Duration.zero;
                  return StreamBuilder<Duration?>(
                    stream: player.positionStream,
                    builder: (context, snapshot2) {
                      var position = snapshot2.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return ProgressBar(
                        progress: position,
                        total: duration,
                        buffered: Duration.zero,
                        timeLabelPadding: -1,
                        timeLabelTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        progressBarColor: const Color(0XFF83C5BE),
                        baseBarColor: Colors.grey[200],
                        bufferedBarColor: Colors.grey[350],
                        thumbColor: const Color(0XFF83C5BE),
                        onSeek: (duration) async {
                          await player.seek(duration);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: loaded
                      ? () async {
                          final newPosition =
                              player.position - const Duration(seconds: 10);
                          await player.seek(newPosition);
                        }
                      : null,
                  icon: const Icon(
                    Icons.fast_rewind_rounded,
                    color: Color(0XFFBBB3B3),
                    size: 35,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0XFF83C5BE),
                  ),
                  child: IconButton(
                    onPressed: loaded
                        ? () {
                            if (isPlaying) {
                              pauseMusic();
                            } else {
                              playMusic();
                            }
                          }
                        : null,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: loaded
                      ? () async {
                          final newPosition =
                              player.position + const Duration(seconds: 10);
                          await player.seek(newPosition);
                        }
                      : null,
                  icon: const Icon(Icons.fast_forward_rounded,
                      color: Color(0XFFBBB3B3), size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
