
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ltcapp/core/services/ExcelConnector.dart';
import 'package:ltcapp/core/utils/DateAndTimeGetter.dart';
import 'package:ltcapp/core/utils/locator.dart';
import 'package:ltcapp/features/home/viewmodel/HomePageViewModel.dart';
import 'package:ltcapp/core/services/CurrentSession.dart';
import 'package:ltcapp/features/login/model/UUIDGetter.dart';
import 'package:ltcapp/features/login/viewmodel/LoginPageViewModel.dart';
import 'package:ltcapp/features/mileage/viewmodel/MileageViewModel.dart';
import 'package:ltcapp/features/registration/viewmodel/SignupRegViewModel.dart';
import 'package:ltcapp/features/vehiclebookout/viewmodel/VehicleStartTripViewModel.dart';
import 'package:ltcapp/core/services/DatabaseConnector.dart';
import 'package:ltcapp/core/services/TelebotConnector.dart';
import 'package:provider/provider.dart';
import 'package:ltcapp/core/config/Router.dart';
import 'package:ltcapp/core/services/Hash.dart';

import 'core/config/ThemeClass.dart';
import 'core/services/Permissions.dart';

//void main() => runApp(MyApp());



void main() async {
  DatabaseHandler db = DatabaseHandler();
  TelebotConnector telebot = new TelebotConnector();
  ExcelHandler excelHandler = new ExcelHandler();
  DateAndTime dt = DateAndTime();
  WidgetsFlutterBinding.ensureInitialized();
  //setupLocator();
  ///Debugging nonsense
  DeviceUUID deviceID = DeviceUUID();
  String _uuid = await deviceID.getUUID();
  print('Device ID is >> $_uuid' );
  CurrentUser.instance.deviceID = _uuid;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LTC App',
        initialRoute: '/',
        onGenerateRoute: Routers.generateRoute,
        theme: ThemeClass.darkTheme,
      );

  }
}
