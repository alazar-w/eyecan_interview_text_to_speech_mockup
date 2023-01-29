// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:interview_mockup/business/business.dart';



// class MockSplashScreenBloc extends MockBloc<SplashScreenEvent, int> implements SplashScreenBloc {}
// abstract class SplashScreenEvent {}
// class AuthenticateUser extends SplashScreenEvent {}

// class SplashScreenBloc extends Bloc<SplashScreenEvent, int> {
//   SplashScreenBloc() : super(0) {
//     on<AuthenticateUser>((event, emit) => emit(state));
//   }
// }

// void main() {
//   //Mock Bloc
//   group('CardItemBlocTest', () {
//     group('whenListen', () {

//       test("Let's mock the CardItemBloc's stream!", () {
//         // Create Mock CounterBloc Instance
//         final bloc = MockSplashScreenBloc();

//         // Stub the listen with a fake Stream
//         whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

//         // Expect that the CounterBloc instance emitted the stubbed Stream of
//         // states
//         expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
//       });
//     });

//     test("Testing Get Access Token", () async {
//       final result = await AccessTokenAPI.getAccessToken("token");
//       expect(result, true);
//     });

//     blocTest<SplashScreenBloc, int>(
//       'emits [] when nothing is added',
//       build: () => SplashScreenBloc(),
//       expect: () => const <int>[],
//     );


//     blocTest<SplashScreenBloc, int>(
//       'emits [0] when AuthenticateUser is fired',
//       build: () => SplashScreenBloc(),
//       act: (bloc) => bloc.add(AuthenticateUser()),
//       expect: () => const <int>[0],
//     );


//   });
// }
