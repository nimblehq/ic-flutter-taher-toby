import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/ui/home/home_state.dart';
import 'package:flutter_survey/ui/home/home_view_model.dart';
import 'package:flutter_survey/ui/home/widget/home_header.dart';
import 'package:flutter_survey/ui/home/widget/home_skeleton_loading.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page_indicator.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page_viewer.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:flutter_survey/ui/widget/snack_bar.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(getIt.get<GetSurveysUseCase>());
});

final _surveysStreamProvider = StreamProvider.autoDispose<List<SurveyModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveys);

final _errorStreamProvider = StreamProvider.autoDispose<String?>(
    (ref) => ref.watch(homeViewModelProvider.notifier).error);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).loadSurveys();
  }

  @override
  Widget build(BuildContext context) {
    final surveys = ref.watch(_surveysStreamProvider).value ?? [];
    final errorMessage = ref.watch(_errorStreamProvider).value ?? "";
    return ref.watch(homeViewModelProvider).when(
          init: () => const HomeSkeletonLoading(),
          loading: () => const HomeSkeletonLoading(),
          loadSurveysSuccess: () =>
              _buildHomeScreen(surveys: surveys, errorMessage: errorMessage),
          loadSurveysError: () =>
              _buildHomeScreen(surveys: surveys, errorMessage: errorMessage),
        );
  }

  Widget _buildHomeScreen({
    required List<SurveyModel> surveys,
    required String errorMessage,
  }) {
    if (errorMessage.isNotEmpty) showSnackBar(context, errorMessage);
    return Scaffold(
      body: Stack(
        children: [
          if (surveys.isNotEmpty) ...[
            HomeSurveyPageViewer(
              surveys: surveys,
              currentPage: _currentPage,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: AppDimensions.spacing200),
                child: HomeSurveyPageIndicator(
                  surveysLength: surveys.length,
                  currentPage: _currentPage,
                ),
              ),
            ),
          ],
          const HomeHeader(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _currentPage.dispose();
    super.dispose();
  }
}
