import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class GetSurveyDetailsInput {
  final String surveyId;

  GetSurveyDetailsInput({
    required this.surveyId,
  });
}

@Injectable()
class GetSurveyDetailsUseCase
    extends UseCase<SurveyDetailsModel, GetSurveyDetailsInput> {
  final SurveyRepository _surveyRepository;

  const GetSurveyDetailsUseCase(this._surveyRepository);

  @override
  Future<Result<SurveyDetailsModel>> call(GetSurveyDetailsInput input) {
    return _surveyRepository
        .getSurveyDetails(
          surveyId: input.surveyId,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<SurveyDetailsModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
