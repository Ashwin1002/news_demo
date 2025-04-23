import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:news_demo/core/core.dart';

sealed class BaseState<T> extends Equatable {
  const BaseState();
  @override
  List<Object?> get props => [];
}

final class Initial<T> extends BaseState<T> {
  const Initial();
  @override
  List<Object?> get props => [];
}

final class Loading<T> extends BaseState<T> {
  const Loading();
  @override
  List<Object?> get props => [];
}

final class Success<T> extends BaseState<T> {
  const Success(this.data);
  final T data;

  @override
  List<Object?> get props => [data];
}

final class Failure<T, E extends AppException> extends BaseState<T> {
  const Failure(this.exception);

  final AppException exception;

  @override
  List<Object?> get props => [exception];
}

extension LoadingStateExtension<T> on BaseState<T> {
  bool get isLoading => this is Loading;
  bool get isSuccess => this is Success;
  bool get isFailure => this is Failure;

  bool get isFinal => isSuccess || isFailure;

  A when<A>({
    required A Function() loading,
    required A Function(T data) success,
    required A Function(AppException exception) failure,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Failure(:final exception) => failure(exception),
      _ => loading(),
    };
  }

  void listenWhen<A>({
    void Function()? initial,
    void Function()? loading,
    void Function(T data)? success,
    void Function(AppException exception)? failure,
  }) {
    return switch (this) {
      Success(:final data) => success?.call(data),
      Failure(:final exception) => failure?.call(exception),
      Loading() => loading?.call(),
      _ => initial?.call(),
    };
  }

  void listenWhenLoadingCallback<A>(
    BuildContext context, {
    void Function(T data)? success,
    void Function(AppException exception)? failure,
  }) {
    return switch (this) {
      Success(:final data) => {context.popLoading(), success?.call(data)},
      Failure(:final exception) => {
        context.popLoading(),
        failure?.call(exception),
      },
      _ => context.showLoading(),
    };
  }
}
