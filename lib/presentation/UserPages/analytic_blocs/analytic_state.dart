part of 'analytic_bloc.dart';

@immutable
abstract class AnalyticState {}

class AnalyticInitial extends AnalyticState {}

class LoadingBarData extends AnalyticState {}

class LoadedBarData extends AnalyticState {
  final BarData? barData;

  LoadedBarData({required this.barData});
}

class LoadingBarDataFail extends AnalyticState {

  final Object? exception;

  LoadingBarDataFail({required this.exception});
}
