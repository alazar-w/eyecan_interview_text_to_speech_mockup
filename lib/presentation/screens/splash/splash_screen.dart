import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview_mockup/business/business.dart';
import 'package:sizer/sizer.dart';
import '../../../business/blocs/blocs.dart';
import '../../../business/cubits/cubits.dart';
import '../../../business/repository/repositories.dart';
import '../../../data/data.dart';
import '../screens.dart';

import 'splash_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ThemeStyle _themeStyle;

  @override
  void initState() {
    super.initState();
    // Get access token from api
  }

  @override
  Widget build(BuildContext context) {
    _themeStyle = context.watch<CurrentThemeBloc>().state;
    context.read<SplashScreenBloc>().add(
          const AuthenticateUser(accessRequest: 'passed'),
        );
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessful) {
          if (!HiveDB.accessedApp()) {
            //app just installed, take to on boarding or something similar logic
            Navigator.pushAndRemoveUntil(
              context,
              Navigation.getRoute(
                HomeScreen(
                  items: [
                    PersistentTabItem(
                      icon: Icons.picture_as_pdf_rounded,
                      title: 'OPEN PDF',
                    ),
                    PersistentTabItem(
                      icon: Icons.checklist,
                      title: 'READ SAMPLE',
                    ),
                    PersistentTabItem(
                      icon: Icons.chrome_reader_mode_rounded,
                      title: 'READ ALL PAGE',
                    ),
                  ],
                ),
              ),
              (route) => false,
            );
          } else {
            //if user exist...
            if (HiveDB.isLoggedIn()) {
              Navigator.pushAndRemoveUntil(
                context,
                Navigation.getRoute(
                  HomeScreen(
                    items: [
                      PersistentTabItem(
                        icon: Icons.picture_as_pdf_rounded,
                        title: 'OPEN PDF',
                      ),
                      PersistentTabItem(
                        icon: Icons.checklist,
                        title: 'READ SAMPLE',
                      ),
                      PersistentTabItem(
                        icon: Icons.chrome_reader_mode_rounded,
                        title: 'READ ALL PAGE',
                      ),
                    ],
                  ),
                ),
                (route) => false,
              );
            } else {
              //take to account creation type
              Navigator.pushAndRemoveUntil(
                context,
                Navigation.getRoute(
                  HomeScreen(
                    items: [
                      PersistentTabItem(
                        icon: Icons.picture_as_pdf_rounded,
                        title: LocalStrings.localString(
                            string: "openPdf", context: context),
                      ),
                      PersistentTabItem(
                        icon: Icons.checklist,
                        title: LocalStrings.localString(
                            string: "readSample", context: context),
                      ),
                      PersistentTabItem(
                        icon: Icons.chrome_reader_mode_rounded,
                        title: LocalStrings.localString(
                            string: "readAllPage", context: context),
                      ),
                    ],
                  ),
                ),
                (route) => false,
              );
            }
          }
        } else if (state is AuthenticationFailed) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: _themeStyle.evenLightColor,
            child: CustomPaint(
              painter: SplashBackground(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageAssets.iconLogo),
                        SizedBox(width: 2.w),
                        AutoSizeText(
                          "speech",
                          style: TextStyle(
                            color: _themeStyle.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxFontSize: 35.sp.floorToDouble(),
                          minFontSize: 20.sp.floorToDouble(),
                        ),
                      ],
                    ),
                    if (state is AuthenticationLoading)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    if (state is AuthenticationFailed)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextButton(
                          child: const Text('Retry'),
                          onPressed: () {
                            context.read<SplashScreenBloc>().add(
                                  const AuthenticateUser(
                                      accessRequest: 'passed'),
                                );
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
