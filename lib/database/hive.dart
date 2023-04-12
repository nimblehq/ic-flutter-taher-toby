import 'package:flutter_survey/model/survey_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> configureLocalStorage() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SurveyModelAdapter());
}
