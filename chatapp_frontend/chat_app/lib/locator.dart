import 'package:chat_app/viemodels/chat_viemodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory<ChatViemodel>(() => ChatViemodel());
}
