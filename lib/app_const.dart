import 'package:parse_server_sdk/parse_server_sdk.dart';
abstract class AppConst {

      static const String PARSE_APP_ID = 'wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v';
      static const String PARSE_APP_URL = 'https://parseapi.back4app.com';
      static const String MASTER_KEY = 'YO2PuRhza2DIV3cxvVkY1319L01x4f8V5lxST20o';
      //const String LIVE_QUERY_URL = 'wss://payface.back4app.io';

}

initParse() async {
  Parse().initialize(AppConst.PARSE_APP_ID, 
                    AppConst.PARSE_APP_URL,
                    masterKey: AppConst.MASTER_KEY,
                    debug: true);
}



