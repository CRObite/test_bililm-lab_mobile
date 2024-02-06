part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingUser extends ProfileState {}

class LoadedUserData extends ProfileState{

  final TestUser? user;
  final Wallet? wallet;
  final List<Subscription>? subscriptions;

  LoadedUserData(this.user, this.wallet, this.subscriptions);
}

class LoadingUserFail extends ProfileState {

  final Object? exception;

  LoadingUserFail({required this.exception});
}
