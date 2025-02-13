import 'package:api_request/api_request.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:test_repo/core/injection.dart';
import 'package:test_repo/features/cards/data/dto/card_dto.dart';
import 'package:test_repo/features/transactions/data/dto/transaction_dto.dart';

import 'app_consts.dart';

class AppSetup {
  static Future<void> setup() async {
    Injection.injectDependencies();
    await Hive.initFlutter();
    Hive.registerAdapter(CardDtoAdapter());
    Hive.registerAdapter(TransactionDtoAdapter());

    //normally this is done in splash screen , but no spalsh is here and opening hive boxes is very quick
    await Hive.openBox<CardDto>(AppConsts.cardBox);
    await Hive.openBox<TransactionDto>(AppConsts.transactionBox);
    ApiRequestOptions.instance
        ?.config(baseUrl: AppConsts.api, enableLog: kDebugMode);
  }
}
