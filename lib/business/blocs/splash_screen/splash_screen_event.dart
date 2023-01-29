part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateUser extends SplashScreenEvent {
  final String accessRequest;

  const AuthenticateUser({required this.accessRequest});
  @override
  List<Object> get props => [accessRequest];
}

class UnAuthenticateUser extends SplashScreenEvent {
  @override
  List<Object> get props => [];
}
