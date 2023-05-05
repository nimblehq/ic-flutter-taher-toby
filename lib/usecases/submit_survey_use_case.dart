import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class SubmitSurveyInput {
  String surveyId;
  List<SubmitSurveyQuestionModel> questions;

  SubmitSurveyInput({
    required this.surveyId,
    required this.questions,
  });
}

@Injectable()
class SubmitSurveyUseCase extends UseCase<void, SubmitSurveyInput> {
  final SurveyRepository _repository;

  const SubmitSurveyUseCase(this._repository);

  @override
  Future<Result<void>> call(SubmitSurveyInput input) {
    return _repository
        .submitSurvey(surveyId: input.surveyId, questions: input.questions)
        // ignore: unnecessary_cast
        .then((value) => Success(null) as Result<void>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
