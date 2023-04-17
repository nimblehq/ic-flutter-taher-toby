import 'package:flutter_survey/database/survey_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

const String _surveysBoxName = 'surveysBox';

@module
abstract class StorageModule {
  @Singleton(as: SurveyStorage)
  @preResolve
  Future<SurveyStorageImpl> provideSurveyStorage() async {
    var box = await Hive.openBox(_surveysBoxName);
    return SurveyStorageImpl(box);
  }
}
