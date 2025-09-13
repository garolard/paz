import 'package:just_audio/just_audio.dart' show AudioPlayer;
import 'package:paz/core/env/env.dart';
import 'package:paz/domain/services/audio_service.dart' show AppAudioService;
import 'package:pocketbase/pocketbase.dart';
import 'package:watch_it/watch_it.dart' show GetIt;

final getIt = GetIt.instance;

Future<void> setupDI() async {
  await Env.load();

  // PocketBase
  getIt.registerLazySingleton(() => PocketBase(Env.pbInstance));
  // getIt.registerLazySingleton<TrackRepository>(() => TrackRepositoryPB(getIt()));

  // Audio
  final player = AudioPlayer();
  getIt.registerSingleton<AudioPlayer>(player);
  getIt.registerLazySingleton(
    () => AppAudioService(player),
    dispose: (as) => as.dispose(),
  );

  // Estado reactive (watch_it): puedes exponer ValueListenable/ChangeNotifier
}
