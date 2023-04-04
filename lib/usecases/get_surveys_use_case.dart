import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class GetSurveysInput {
  final int pageNumber;
  final int pageSize;

  GetSurveysInput({
    required this.pageNumber,
    required this.pageSize,
  });
}

@Injectable()
class GetSurveysUseCase extends UseCase<List<SurveyModel>, GetSurveysInput> {
  final SurveyRepository _surveyRepository;

  const GetSurveysUseCase(this._surveyRepository);

  @override
  Future<Result<List<SurveyModel>>> call(GetSurveysInput input) {
    return _surveyRepository
        .getSurveys(
          pageNumber: input.pageNumber,
          pageSize: input.pageSize,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<List<SurveyModel>>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
