import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashBloc()..add(SplashInitialEvent());
      },
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is UserHasNotRegistered) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/role_selection_screen", (r) => false);
          } else if (state is UserHasRegistered) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/dashboard", (r) => false,
                arguments: {"userVerified": false});
          } else if (state is LoginNeeded) {
            Navigator.of(context).popAndPushNamed('/login_screen');
          }
        },
        child:
            BlocBuilder<SplashBloc, SplashState>(builder: (context, snapshot) {
          return Scaffold(
            body: Container(
                child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/splash_screen.png',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/splash_group_icons.png',
                        height: 318,
                        width: 312,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/geo_fresh_image.png',
                        height: 34,
                        width: 54,
                      ))
                ],
              ),
            )),
          );
        }),
      ),
    );
  }
}
