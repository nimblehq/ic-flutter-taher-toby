import '../../api/exception/network_exceptions.dart';

part 'use_case_result.dart';

abstract class BaseUseCase<T extends Result> {
  const BaseUseCase();
}

abstract class UseCase<T, I> extends BaseUseCase<Result<T>> {
  const UseCase() : super();

  Future<Result<T>> call(I input);
}

abstract class NoParamsUseCase<T> extends BaseUseCase<Result<T>> {
  const NoParamsUseCase() : super();

  Future<Result<T>> call();
}

abstract class SimpleUseCase<T> {
  const SimpleUseCase();

  T call();
}
