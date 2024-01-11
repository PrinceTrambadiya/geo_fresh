import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/add_product/add_product_form.dart';
import 'package:geo_fresh/ui/businessman/businessman_form_screen.dart';
import 'package:geo_fresh/ui/businessman/businessmsn_address_screen.dart';
import 'package:geo_fresh/ui/businessman/comfirm_transportation.dart';
import 'package:geo_fresh/ui/businessman/product_list_screen.dart';
import 'package:geo_fresh/ui/drawer/contact_us/contact_us.dart';
import 'package:geo_fresh/ui/drawer/my_products/my_products_screen.dart';
import 'package:geo_fresh/ui/drawer/my_profile/my_profile.dart';
import 'package:geo_fresh/ui/drawer/my_purchases/my_purchases.dart';
import 'package:geo_fresh/ui/farmer/farmer_address_details_form.dart';
import 'package:geo_fresh/ui/farmer/farmer_form_screen.dart';
import 'package:geo_fresh/ui/farmer/farmer_notification_screen.dart';
import 'package:geo_fresh/ui/farmer/product_bid_list_screen.dart';
import 'package:geo_fresh/ui/home/dashboard.dart';
import 'package:geo_fresh/ui/login/login_screen.dart';
import 'package:geo_fresh/ui/login/otp_verification_screen.dart';
import 'package:geo_fresh/ui/role_selection_screen/role_selection_screen.dart';
import 'package:geo_fresh/ui/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //debugPrint(settings.name);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashScreen(),
        );
      case '/login_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => LoginScreen(),
        );
      case '/otp_verification_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => OTPVerificationScreen(
            argument: settings.arguments,
          ),
        );
      case '/role_selection_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => RoleSelectionScreen(),
        );
      case '/farmer_form_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => FarmerFormScreen(
            argument: settings.arguments,
          ),
        );
      case '/businessman_form_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BusinessmanFormScreen(
            argument: settings.arguments,
          ),
        );
      case '/dashboard':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Dashboard(
              // arguments: settings.arguments,
              ),
        );
      case '/add_product_form':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AddProductForm(),
        );
      case '/product_list_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ProductListScreen(),
        );
      case '/farmer_notification_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => FarmerNotificationScreen(),
        );
      case '/farmer_products_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MyProductsScreen(arguments: settings.arguments),
        );
      case '/product_bid_list_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              ProductBidListScreen(arguments: settings.arguments),
        );
      case '/farmer_bank_details_form':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              FarmerAddressDetailsForm(arguments: settings.arguments),
        );
      case '/businessman_address_screen':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              BusinessManAddressScreen(arguments: settings.arguments),
        );
      case '/confirm_transportation':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ConfirmTransportation(),
        );
      case '/my_profile':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MyProfile(),
        );
      case '/my_purchases':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MyPurchases(),
        );
      case '/contact_us':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ContactUs(),
        );
    }
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          body: Container(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Route Error",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("No Route Found : "),
                  Text(
                    settings.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
