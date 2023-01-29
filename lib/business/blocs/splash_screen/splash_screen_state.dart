part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends SplashScreenState {}

class AuthenticationLoading extends SplashScreenState {}

class AuthenticationSuccessful extends SplashScreenState {}

class AuthenticationFailed extends SplashScreenState {
  final String error;

  const AuthenticationFailed(this.error);

  @override
  List<Object> get props => [error];
}
