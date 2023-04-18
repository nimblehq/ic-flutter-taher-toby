import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _surveysBoxName = 'surveysBox';

@module
abstract class StorageModule {
  @Singleton(as: SurveyStorage)
  @preResolve
  Future<SurveyStorageImpl> provideSurveyStorage() async {
    var box = await Hive.openBox(_surveysBoxName);
    return SurveyStorageImpl(box);
  }

  @Singleton(as: SecureStorage)
  SecureStorageImpl provideSecureStorage() {
    var secureStorage = const FlutterSecureStorage();
    return SecureStorageImpl(secureStorage);
  }
}
