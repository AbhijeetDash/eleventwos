import 'package:get_it/get_it.dart';

import '../services/services.dart';

final locator = GetIt.instance;

class UtilsLocator {
  // Register all the services
  // This allows us to use Mokito to test the service later on...
  void setupLocator() {
    locator.registerSingleton<BlockService>(BlockServiceImpl());
    locator.registerSingleton<BoardService>(BoardServiceImpl());
  }
}
