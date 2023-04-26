import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/form/form_state.dart';
import 'package:flutter_survey/ui/form/form_view_model.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_detail_page.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_question_page.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/next_button.dart';
import 'package:flutter_survey/ui/widget/snack_bar.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';

const _navigationDuration = 400;

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
  var _showStartSurveyButton = true;
  var _showNextSurveyButton = false;
  var _showSubmitSurveyButton = false;
  var _showCloseButton = false;

  final _appNavigator = getIt.get<AppNavigator>();
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
    final questions = surveyDetails?.questions ?? [];
    final questionTotal = questions.length;
    if (errorMessage.isNotEmpty) showSnackBar(context, errorMessage);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            if (surveyDetails != null) ...[
              DimmedBackground(background: surveyDetails.coverImageUrl),
              PageView.builder(
                itemCount: 1 + questionTotal,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return FormSurveyDetailPage(
                      surveyDetails: surveyDetails,
                    );
                  } else {
                    return FormSurveyQuestionPage(
                      question: questions[index - 1],
                      questionIndex: index,
                      questionTotal: questionTotal,
                    );
                  }
                },
                onPageChanged: (int index) {
                  setState(() {
                    _showStartSurveyButton = index == 0;
                    _showNextSurveyButton = index > 0 && index < questionTotal;
                    _showSubmitSurveyButton = index == questionTotal;
                    _showCloseButton = index != 0;
                  });
                },
              ),
              _buildCloseButton(context),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildStartSurveyButton(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildNextSurveyButton(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildSubmitSurveyButton(),
              ),
            ] else ...[
              const SafeArea(child: BackButton(color: Colors.white))
            ],
            if (isLoading) _buildCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Visibility(
      visible: _showCloseButton,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: RawMaterialButton(
            shape: const CircleBorder(),
            fillColor: AppColors.white20,
            constraints: const BoxConstraints.tightFor(
              width: AppDimensions.closeButtonSize,
              height: AppDimensions.closeButtonSize,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: AppDimensions.closeButtonIconSize,
            ),
            onPressed: () => _appNavigator.navigateBack(context),
          ),
        ),
      ),
    );
  }

  Widget _buildStartSurveyButton() => Visibility(
        visible: _showStartSurveyButton,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing20),
          child: ElevatedButton(
            onPressed: () => _navigateNextPage(),
            child: Text(
              AppLocalizations.of(context)!.start_survey,
            ),
          ),
        ),
      );

  Widget _buildNextSurveyButton() => Visibility(
        visible: _showNextSurveyButton,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing20),
          child: NextButton(
            onNextButtonPressed: () => _navigateNextPage(),
          ),
        ),
      );

  void _navigateNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: _navigationDuration),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSubmitSurveyButton() => Visibility(
        visible: _showSubmitSurveyButton,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing20),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Integrate click-event from survey details #41
            },
            child: Text(
              AppLocalizations.of(context)!.submit_survey,
            ),
          ),
        ),
      );
}
