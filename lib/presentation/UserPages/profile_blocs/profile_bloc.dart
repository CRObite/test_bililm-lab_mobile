import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/balance_service.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/subscription.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
import 'package:test_bilimlab_project/domain/wallet.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.context) : super(ProfileInitial()) {
    on<GetUser>((event, emit){ _load(event, emit); });
  }

  final BuildContext context;


  Future<void> _load(
      GetUser event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      if (state is! LoadedUserData) {
        emit(LoadingUser());
      }

      TestUser? user;
      Wallet? wallet;
      List<Subscription>? subscriptions;

      CustomResponse response = await LoginService().userGetMe();

      if (response.code == 200) {
        user = response.body;
      } else {
        ResponseHandle.handleResponseError(response,context);
      }

      response = await  BalanceService().getBalance();
      if (response.code == 200) {
        wallet = response.body;
      } else {
        ResponseHandle.handleResponseError(response,context);
      }

      response = await BalanceService().getAllSubscription();

      if (response.code == 200) {
        subscriptions = response.body;

        emit(LoadedUserData(user, wallet, subscriptions));
      } else {
        ResponseHandle.handleResponseError(response,context);
      }


    } catch (e) {
      emit(LoadingUserFail(exception: e));

    } finally {

    }
  }
}
