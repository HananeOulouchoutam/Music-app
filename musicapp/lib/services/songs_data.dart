import 'package:musicapp/models/song_Model.dart';

class Songs {
  List<SongModel> songs = [];

  Songs() {
    getSongs();
  }

  List<SongModel> getSongs() {
    SongModel songModel = SongModel();
    songModel.title = "Masha allah";
    songModel.imageUrl = "assets/images/masha-allah-img.png";
    songModel.audioUrl = "asset:///assets/audio/masha-allah-maher-zain.mp3";
    songModel.artist = "Maher Zain";
    songs.add(songModel);

    songModel = SongModel();
    songModel.title = "Freedom";
    songModel.imageUrl = "assets/images/freedom-img.jpg";
    songModel.audioUrl = "asset:///assets/audio/paradise-maher-zain.mp3";
    songModel.artist = "Maher Zain";
    songs.add(songModel);

    songModel = SongModel();
    songModel.title = "Paradise";
    songModel.imageUrl = "assets/images/paradise-img.jpg";
    songModel.audioUrl = "asset:///assets/audio/freedom-maher-zain.mp3";
    songModel.artist = "Maher Zain";
    songs.add(songModel);

    songModel = SongModel();
    songModel.title = "Paradise";
    songModel.imageUrl = "assets/images/paradise-img.jpg";
    songModel.audioUrl = "asset:///assets/audio/freedom-maher-zain.mp3";
    songModel.artist = "Maher Zain";
    songs.add(songModel);

    songModel = SongModel();
    songModel.title = "Paradise";
    songModel.imageUrl = "assets/images/paradise-img.jpg";
    songModel.audioUrl = "asset:///assets/audio/freedom-maher-zain.mp3";
    songModel.artist = "Maher Zain";
    songs.add(songModel);

    return songs; 
  }

  void addSong(SongModel song) {
    songs.add(song);
  }
}
