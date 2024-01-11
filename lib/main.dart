import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/businesman_bloc/businessman_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/providers/address_provider.dart';
import 'package:geo_fresh/providers/user_provider.dart';
import 'package:geo_fresh/routes/route_generator.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AddressProvider>(
          create: (_) => AddressProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<FarmerBloc>(
          create: (context) {
            return FarmerBloc();
          },
        ),
        BlocProvider<BusinessmanBloc>(
          create: (context) {
            return BusinessmanBloc();
          },
        ),
      ], child: MyApp())));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initializeFlutterFireFuture;

  @override
  void initState() {
    super.initState();
    initializeFlutterFireFuture = _initializeFlutterFire();
  }

  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        //initialize SizerUtil()
        SizerUtil().init(constraints, orientation);
        return MaterialApp(
          title: 'Geo Fresh',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // this line is important
            RefreshLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/',
        );
      });
    });
  }
}
