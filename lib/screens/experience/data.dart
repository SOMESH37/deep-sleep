import 'package:deep_sleep/exporter.dart';

class ExpTileData {
  final String name;
  final String imgPath;
  final String source;
  final String artist;
  const ExpTileData({
    required this.name,
    required this.imgPath,
    required this.source,
    required this.artist,
  });
  void play() {
    audioPlayer.pause();
    expPlayer.open(
      Audio.network(
        source,
        cached: true,
        metas: Metas(
          title: name,
          artist: artist,
          image: MetasImage.asset(imgPath),
        ),
      ),
      showNotification: true,
      loopMode: LoopMode.single,
      notificationSettings: const NotificationSettings(
        nextEnabled: false,
        prevEnabled: false,
        stopEnabled: false,
      ),
    );
  }

  static final natures = items.where((e) => e.artist == 'Nature').toList();
  static final instruments =
      items.where((e) => e.artist == 'Instrument').toList();

  static final items = <ExpTileData>[
    ExpTileData(
      imgPath: Assets.guitar.path,
      artist: 'Instrument',
      name: "Acoustic guitar",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/acoustic_guitar.mp3",
    ),
    ExpTileData(
      imgPath: Assets.beach.path,
      artist: 'Nature',
      name: "Beach",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/beach.mp3",
    ),
    ExpTileData(
      imgPath: Assets.breeze.path,
      artist: 'Nature',
      name: "Breeze",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/breeze.mp3",
    ),
    ExpTileData(
      imgPath: Assets.camping.path,
      artist: 'Nature',
      name: "Camp fire",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/camp fire.mp3",
    ),
    ExpTileData(
      imgPath: Assets.drizzle.path,
      artist: 'Nature',
      name: "Drizzle",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/drizzle_rain.mp3",
    ),
    ExpTileData(
      imgPath: Assets.flute.path,
      artist: 'Instrument',
      name: "Flute",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/flute.mp3",
    ),
    ExpTileData(
      imgPath: Assets.harp.path,
      artist: 'Instrument',
      name: "Harp",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/harp.mp3",
    ),
    ExpTileData(
      imgPath: Assets.kalimba.path,
      artist: 'Instrument',
      name: "Kalimba",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/kalimba.mp3",
    ),
    ExpTileData(
      imgPath: Assets.musicBox.path,
      artist: 'Instrument',
      name: "Music box",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/musicbox.mp3",
    ),
    ExpTileData(
      imgPath: Assets.piano.path,
      artist: 'Instrument',
      name: "Piano",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/piano.mp3",
    ),
    ExpTileData(
      imgPath: Assets.seaWave.path,
      artist: 'Nature',
      name: "Sea waves",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/sea_waves.mp3",
    ),
    ExpTileData(
      imgPath: Assets.swamp.path,
      artist: 'Nature',
      name: "Swamp",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/swamp.mp3",
    ),
    ExpTileData(
      imgPath: Assets.ukelele.path,
      artist: 'Instrument',
      name: "Ukelele",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/ukelele.mp3",
    ),
    ExpTileData(
      imgPath: Assets.waterfall.path,
      artist: 'Nature',
      name: "Waterfall",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/waterfall.mp3",
    ),
    ExpTileData(
      imgPath: Assets.windChimes.path,
      artist: 'Instrument',
      name: "Wind chimes",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-instrument/wind_chime.mp3",
    ),
    ExpTileData(
      imgPath: Assets.woodFire.path,
      artist: 'Nature',
      name: "Wood fire",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/experiences-nature/wood fire.mp3",
    ),
  ];
}
