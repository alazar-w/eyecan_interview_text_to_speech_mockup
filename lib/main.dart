import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:interview_mockup/presentation/screens/screens.dart';
import 'package:sizer/sizer.dart';
import 'business/business.dart';
import 'helper/helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await HiveDB.initHive();
  //[DevicePreview] Helps in simulating different screen sizes
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //[Sizer] helps in adapting height and width of widgets, fonts etc.
    // according to screen sizes
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CurrentThemeBloc>(
              create: (_) => CurrentThemeBloc(),
            ),
            BlocProvider<SplashScreenBloc>(
              create: (_) => SplashScreenBloc(),
            ),
          ],
          child: MaterialApp(
            useInheritedMediaQuery: true,
            title: 'PrayerList',
            theme: ThemeData(
              fontFamily: 'Urbanist',
            ),
            scrollBehavior: const ScrollBehaviorModified(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return DevicePreview.appBuilder(
                context,
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                ),
              );
            },
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('fr', ''), // // Spanish
            ],
            locale: const Locale("en"),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
