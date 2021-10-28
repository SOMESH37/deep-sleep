import '/exporter.dart';

enum DownloadStatus { notDownloaded, downloading, downloaded }

class RestTileData {
  String name;
  String imgPath;
  String source;
  int downloadStatus;
  RestTileData({
    required this.name,
    required this.imgPath,
    required this.source,
    this.downloadStatus = 0,
  });
  static final sleepItems = <RestTileData>[
    RestTileData(
      name: 'Alone',
      imgPath: Assets.scenery1.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Alone+-+Emmit+Fenn.mp3',
    ),
    RestTileData(
      name: 'Blissfull healing',
      imgPath: Assets.scenery2.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Blissful+Healing+By+Chris+Collins.mp3',
    ),
    RestTileData(
      name: 'Celestial sleep',
      imgPath: Assets.scenery3.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Celestial+Sleep+By+Cindy+Muelmann.mp3',
    ),
    RestTileData(
      name: 'Delta dream',
      imgPath: Assets.scenery4.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/delta+dream+by+Rachel+schwartz.mp3',
    ),
    RestTileData(
      name: 'Earth',
      imgPath: Assets.scenery5.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Earth+By+MacDeMarco.mp3',
    ),
    RestTileData(
      name: "Gaia's journey",
      imgPath: Assets.scenery6.path,
      source:
          "https://deepsleep.s3.ap-south-1.amazonaws.com/gaia's+journey+by+alex+mill.mp3",
    ),
    RestTileData(
      name: 'Presence of peace',
      imgPath: Assets.scenery7.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/presence+of+peace+by+chris+collins.mp3',
    ),
    RestTileData(
      name: 'Silence and everything in it',
      imgPath: Assets.scenery8.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Silence+and+Everything+In+It+By+Alice+Powell.mp3',
    ),
    RestTileData(
      name: 'Sleeping universe',
      imgPath: Assets.scenery9.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/sleeping+universe+by+ramy+michigan.mp3',
    ),
    RestTileData(
      name: 'Synchronized reality',
      imgPath: Assets.scenery10.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/synchronized+reality+by+alan+weinmann.mp3',
    ),
    RestTileData(
      name: 'Tropical rain',
      imgPath: Assets.scenery11.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/Tropical+Rain+by+MacDeMarco.mp3',
    ),
    RestTileData(
      name: 'Winter snow',
      imgPath: Assets.scenery12.path,
      source:
          'https://deepsleep.s3.ap-south-1.amazonaws.com/winter+snow+by+MacDeMarco.mp3',
    ),
  ];
}
