import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_state.freezed.dart';

@freezed
class FormState with _$FormState {
  const factory FormState.init() = _Init;

  const factory FormState.loading() = _Loading;

  const factory FormState.loadSurveyDetailsSuccess() =
      _LoadSurveyDetailsSuccess;

  const factory FormState.loadSurveyDetailsError() = _LoadSurveyDetailsError;
}
