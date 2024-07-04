import 'package:flutter/material.dart';
import 'package:musicapp/models/song_Model.dart';
import 'package:musicapp/screens/song_screen.dart';
import 'package:musicapp/services/songs_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Songs songsData = Songs();

  final List<SongModel> myListSongs = [];

  void addToMySongs(
      String title, String artist, String audioUrl, String imageUrl) {
    SongModel newSong = SongModel(
      title: title,
      artist: artist,
      audioUrl: audioUrl,
      imageUrl: imageUrl,
    );

    if (!myListSongs.contains(newSong)) {
      setState(() {
        myListSongs.add(newSong);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to favorites: $title'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title is already in favorites!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void removeFromFavorites(String songTitle) {
    setState(() {
      myListSongs.removeWhere((song) => song.title == songTitle);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed from favorites: $songTitle'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<SongModel> trendingMusic = songsData.getSongs();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JotiOne',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF83C5BE)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 127, 198, 191),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: const Color(0xFF83C5BE)!,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (query) {
                  // Handle search query changes
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Trending Music',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'JotiOne',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 120.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingMusic.length,
                  itemBuilder: (context, index) {
                    String title = trendingMusic[index].title!;
                    String artist = trendingMusic[index].artist!;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SongScreen(
                              title: trendingMusic[index].title!,
                              artist: trendingMusic[index].artist!,
                              audioUrl: trendingMusic[index].audioUrl!,
                              imageUrl: trendingMusic[index].imageUrl!,
                              onFavoritePressed: addToMySongs,
                              removeFromFavorites: removeFromFavorites,
                              favorite: myListSongs.any((song) =>
                                  song.title == trendingMusic[index].title),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 160.0,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                trendingMusic[index].imageUrl!,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 5.0, left: 10.0, right: 10.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF83C5BE)
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            fontFamily: 'JosefinSans',
                                          ),
                                        ),
                                        Text(
                                          artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            // fontFamily: 'JosefinSans',
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Positioned(
                                bottom: 15.0,
                                right: 16.0,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Your List',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'JotiOne',
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF42999A),
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: myListSongs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: const Color(0XFFBBB3B3),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              myListSongs[index].imageUrl!,
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myListSongs[index].title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                fontFamily: 'JosefinSans',
                                color: Color(0xFF83C5BE),
                              ),
                            ),
                            Text(
                              myListSongs[index].artist!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                // fontFamily: 'JosefinSans',
                                color: Color(0XFFBBB3B3),
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<int>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Color(0XFFBBB3B3),
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 8.0),
                                  Text('Supprimer'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(width: 8.0),
                                  Text('Partager'),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 0) {
                              removeFromFavorites(myListSongs[index].title!) ;
                            } else if (value == 1) {
                              // Logic to share the song
                            }
                          },
                        ),
                        onTap: () {
                          //Navigate to SongScreen when tapped
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SongScreen(
                                  title: myListSongs[index].title!,
                                  artist: myListSongs[index].artist!,
                                  audioUrl: myListSongs[index].audioUrl!,
                                  imageUrl: myListSongs[index].imageUrl!,
                                  onFavoritePressed: addToMySongs,
                                  removeFromFavorites: removeFromFavorites,
                                  favorite: true),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
