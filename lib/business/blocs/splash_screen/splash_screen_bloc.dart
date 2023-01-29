import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../repository/apis/access_token_api.dart';
part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(AuthenticationInitial()) {
    on<AuthenticateUser>(_onAuthenticateUser);
    on<UnAuthenticateUser>((event, emit) {
      Logger().e('Method not implemented');
    });
  }

  _onAuthenticateUser(event, emit) async {
    emit(AuthenticationLoading());
    try {
      bool response = await AccessTokenAPI.getAccessToken(event.accessRequest);
      if (response) {
        emit(AuthenticationSuccessful());
      } else {
        emit(const AuthenticationFailed("Something went wrong"));
      }
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }
}
