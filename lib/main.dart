import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:widget_detail/res/my_http_override.dart';
import 'views/home/home_screen.dart';

void main() {
  runApp(const MyApp());

  HttpOverrides.global = MyHttpOverride();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f96a27ab-bd4e-4c1d-8ba7-f66e91cd9009");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.pink
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Poppins'
        )
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primarySwatch: Colors.pink,
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
          )
      ),

      home: MyHomePage(title: 'Flutter '),
      // home: Center(child: Text('Hello Flutter', style: TextStyle(fontSize: 30),)),
    );
  }
}

