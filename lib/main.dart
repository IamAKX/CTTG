import 'package:cttgfahrer/screens/home/home_screen.dart';
import 'package:cttgfahrer/screens/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('loggedIn') == null) {
    prefs.setBool('loggedIn', false);
  }
  if (prefs.getString('locale') == null) {
    prefs.setString('locale', 'de_AT');
  }
  for (var key in prefs.getKeys()) {
    print('Key: ${key}, value: ${prefs.get(key)}');
  }
  runApp(
    EasyLocalization(
      child: prefs.getBool('loggedIn') ? HomePage() : MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('de', 'AT')],
      path: 'assets',
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTTG Fahrer',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      home: LoginStateLess(),
      onGenerateRoute: RouterGenerator.generatedRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTTG Fahrer',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      home: HomeStateLess(),
      onGenerateRoute: RouterGenerator.generatedRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
