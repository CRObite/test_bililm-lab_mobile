import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

part 'analytic_event.dart';
part 'analytic_state.dart';

class AnalyticBloc extends Bloc<AnalyticEvent, AnalyticState> {
  AnalyticBloc(this.context) : super(AnalyticInitial()) {
    on<GetAllData>(_load);
  }

  final BuildContext context;

  Future<void> _load(
      GetAllData event,
      Emitter<AnalyticState> emit,
      ) async {
    try {
      if (state is! LoadedBarData) {
        emit(LoadingBarData());
      }
      CustomResponse response = await TestService().getStatistics();

      if (response.code == 200) {
        emit(LoadedBarData(barData: response.body));
      }else {
        ResponseHandle.handleResponseError(response,context);
      }


    } catch (e) {
      emit(LoadingBarDataFail(exception: e));

    } finally {

    }
  }

}
