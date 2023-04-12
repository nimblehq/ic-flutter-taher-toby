import 'package:flutter_survey/model/survey_model.dart';
import 'package:hive/hive.dart';

const String _surveysKey = 'surveys';

abstract class SurveyStorage {
  List<SurveyModel> get surveys;

  void saveSurveys(List<SurveyModel> surveys);
}

class SurveyStorageImpl extends SurveyStorage {
  final Box _surveysBox;

  SurveyStorageImpl(this._surveysBox);

  @override
  List<SurveyModel> get surveys {
    List<dynamic> value = _surveysBox.get(_surveysKey, defaultValue: []);
    return List<SurveyModel>.from(value);
  }

  @override
  void saveSurveys(List<SurveyModel> surveys) async {
    await _surveysBox.put(_surveysKey, surveys);
  }
}
