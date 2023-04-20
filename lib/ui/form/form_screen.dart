import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/form/form_state.dart';
import 'package:flutter_survey/ui/form/form_view_model.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_detail_page.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_question_page.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/snack_bar.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';

final formViewModelProvider =
    StateNotifierProvider.autoDispose<FormViewModel, FormState>((ref) {
  return FormViewModel(getIt.get<GetSurveyDetailsUseCase>());
});

final _surveyDetailsStreamProvider =
    StreamProvider.autoDispose<SurveyDetailsModel>(
        (ref) => ref.watch(formViewModelProvider.notifier).surveyDetails);

final _errorStreamProvider = StreamProvider.autoDispose<String?>(
    (ref) => ref.watch(formViewModelProvider.notifier).error);

class FormScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const FormScreen({
    Key? key,
    required this.surveyId,
  }) : super(key: key);

  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends ConsumerState<FormScreen> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    ref.read(formViewModelProvider.notifier).loadSurveyDetails(widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    final surveyDetails = ref.watch(_surveyDetailsStreamProvider).value;
    final errorMessage = ref.watch(_errorStreamProvider).value ?? "";
    return ref.watch(formViewModelProvider).when(
          init: () => _buildFormScreen(isLoading: true),
          loading: () => _buildFormScreen(isLoading: true),
          loadSurveyDetailsSuccess: () => _buildFormScreen(
            surveyDetails: surveyDetails,
          ),
          loadSurveyDetailsError: () => _buildFormScreen(
            errorMessage: errorMessage,
          ),
        );
  }

  Widget _buildFormScreen({
    bool isLoading = false,
    SurveyDetailsModel? surveyDetails,
    String errorMessage = "",
  }) {
    if (errorMessage.isNotEmpty) showSnackBar(context, errorMessage);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (surveyDetails != null) ...[
            DimmedBackground(background: surveyDetails.coverImageUrl),
            PageView.builder(
              // TODO: Integrate item count from survey details #25
              itemCount: 3,

              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return FormSurveyDetailPage(
                    surveyDetails: surveyDetails,
                  );
                } else {
                  return const FormSurveyQuestionPage();
                }
              },
            ),
            _buildStartButton()
          ] else ...[
            Column(
              children: const [
                SizedBox(height: AppDimensions.spacing20),
                BackButton(color: Colors.white)
              ],
            )
          ],
          if (isLoading) _buildCircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildStartButton() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Integrate click-event from survey details #25
          },
          child: Text(
            AppLocalizations.of(context)!.start_survey,
          ),
        ),
      ),
    );
  }
}
