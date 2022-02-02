import 'package:deep_sleep/exporter.dart';
part 'open_player.dart';
part 'closed_player.dart';
part 'position_seek_widget.dart';

const _pad = EdgeInsets.all(32);
final _playerDuration = kAnimationDuration * 0.3;
const _smallIconSize = 32.0;
Stopper? _stopper;
late AssetsAudioPlayer audioPlayer;
late AssetsAudioPlayer expPlayer;

void closeAudioPlayer() {
  audioPlayer
    ..setPlaySpeed(1)
    ..stop();
  _stopper = null;
}
