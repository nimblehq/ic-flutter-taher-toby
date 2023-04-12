import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetCachedSurveysUseCase extends SimpleUseCase<List<SurveyModel>> {
  final SurveyStorage _surveyStorage;

  GetCachedSurveysUseCase(this._surveyStorage);

  @override
  List<SurveyModel> call() => _surveyStorage.surveys;
}
