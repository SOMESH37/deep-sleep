import 'package:deep_sleep/exporter.dart';
import 'package:flowder/flowder.dart';

class RestTileData {
  final String name;
  final String imgPath;
  final String source;
  final String artist;
  final Metas meta;
  RestTileData({
    required this.name,
    required this.imgPath,
    required this.source,
    required this.artist,
  }) : meta = Metas(
          title: name,
          artist: artist,
          image: MetasImage.asset(imgPath),
        );

  void play() {
    final isOffline =
        HiveHelper.downloadStat(name) == DownloadStatus.downloaded;
    expPlayer.stop();
    audioPlayer.open(
      isOffline
          ? Audio.file('${MyDirectory.getDownloadPath}/$name', metas: meta)
          : Audio.network(source, cached: true, metas: meta),
      showNotification: true,
      loopMode: LoopMode.single,
      notificationSettings: const NotificationSettings(
        nextEnabled: false,
        prevEnabled: false,
      ),
    );
  }

  Future<void> download() async {
    final options = DownloaderUtils(
      file: File('${MyDirectory.getDownloadPath}/$name'),
      onDone: () {
        HiveHelper.downloadStatBox.put(name, 101);
      },
      progress: ProgressImplementation(),
      progressCallback: (cur, net) {
        final per = cur * 100 ~/ net;
        if (HiveHelper.downloadStatBox.get(name) != per) {
          HiveHelper.downloadStatBox.put(name, per);
        }
      },
      deleteOnCancel: true,
    );
    Flowder.download(source, options);
  }

  static final napItems = items.where((e) => e.artist == 'Power nap').toList();
  static final sleepItems =
      items.where((e) => e.artist == 'Good sleep').toList();

  static final items = <RestTileData>[
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery1.path,
      name: "Calm dawn",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/%F0%9F%9B%80+Calm+Music+(No+Copyright)++_Dawn_+by+%40Sappheiros++%F0%9F%87%BA%F0%9F%87%B8.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery2.path,
      name: "Deep relaxation",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Just+relax+_+Meditation+and+relaxation+music+no+copyright.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery17.path,
      name: "Deepest sleep",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/FREE+ROYALTY+FREE+RELAXING+MUSIC+by+Liborio+Conti+(No+Copyright)+Royalty+Free+Music+Relaxing.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery3.path,
      name: "Forseeing",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Forest+Videos+with+Ambient+and+Calm+Music+-+No+Copyright+Videos+-+Nature+Videos+-+FreeCinematics.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery4.path,
      name: "Forty winks",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/%F0%9F%94%B4No+copyright+Relaxing+Flute+Music+_+Krishna+Flute+Music+_+Uplifting+Flute+Meditation+Music.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery16.path,
      name: "Deep slumber",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/extremely_powerful_self_connection_meditation_432_hz_3_4_hz_binaural_beats_meditation_4673652067851190593.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery5.path,
      name: "Habitual meditation",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Buddhist+Meditation+Music+_+(Om+Music)_++Background+Music+_No+Copyright+_Free+Download_.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery18.path,
      name: "Hypnotic rest",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/binaural_journey_delta_theta_alpha_beta_gamma_wave_music_royalty_free_-5090846020745033145.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery6.path,
      name: "Insightful dusk",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/10+minute+meditation+music+-+10+minute+relaxing+meditation+music.mp3",
    ),
    /* RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery7.path,
      name: "Light meditative",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/No+Copyright+Meditation+Music+_+Music+for+Your+Project+-+_Nuance_+-+Royalty+Free.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery19.path,
      name: "Lucid dreams",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/Deep+Relaxing+Sleep+Music+Royalty+Free+_+Binaural+Beats+Delta+Waves+Deep+Meditation.mp3",
    ), */
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery20.path,
      name: "Pensive dreams",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/alpha_theta_border_beats_brain_waves_binaural_beats_copyright_free_music_6_8hz_-745380646720045013.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery8.path,
      name: "Power",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Free+Meditation+Music+528Hz+Music+-+No+CopyRight+Music+-+Royalty+Free+Healing+Music.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery9.path,
      name: "Rainforest cat",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/(No+Copyright)+Relaxing+Music-Relaxing+Jungle+Sound+With+Birds%2C+Nature+-Meditation+%26+Stress+Relief.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery21.path,
      name: "Recharge slumber",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/theta_waves_binaural_beats_meditation_music_royalty_free_deep_healing_meditation_-2496385461083925039.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery10.path,
      name: "Refresh",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/FREE+Meditation+Music+432Hz+-+Download+For+FREE+-+%5B++No+CopyRight++%5D.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery11.path,
      name: "Regenerate",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/free+no+copyright+yoga+background+music+Free+to+use+meditation+music.mp3",
    ),
    RestTileData(
      artist: 'Good sleep',
      imgPath: Assets.scenery22.path,
      name: "Restful rejuvenation",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/good-sleep/no_copyright_music_morning_mist_1_hour_meditation_music_copyright_free_music_-4481702425328499915.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery12.path,
      name: "Reviving rest",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Nature+Cinematic+Videos+with+Relaxing+Music+-+No+Copyright+Videos+and+Music+-+FreeCinematics.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery13.path,
      name: "Shuteye",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/%E2%98%80%EF%B8%8F+Relaxing+Music+(No+Copyright)+-+_Shine_+by+Onycs+%F0%9F%87%AB%F0%9F%87%B7.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery14.path,
      name: "Stargazing",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Dreamer+by+Hazy+-+Cinematic+-+Ambient+-+No+Copyright+Music.mp3",
    ),
    RestTileData(
      artist: 'Power nap',
      imgPath: Assets.scenery15.path,
      name: "Yogic",
      source:
          "https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/Relaxing+Background+Music+For+Videos++Meditations%2C+Yoga+-+no+copyright+%5BNCS+Collection%5D.mp3",
    ),
  ];

  /*  RestTileData(
      name: 'Alone',
      imgPath: Assets.scenery1.path,
      source:
          'https://deep-sleep-new.s3.ap-south-1.amazonaws.com/naps/%F0%9F%9B%80+Calm+Music+(No+Copyright)++_Dawn_+by+%40Sappheiros++%F0%9F%87%BA%F0%9F%87%B8.mp3',
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
    ), */
}
