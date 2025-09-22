import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:habitt/habit/view_model.dart';
import 'package:habitt/theme.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

import 'package:habitt/habit/home_screen.dart';
import 'package:habitt/habit/repository.dart';
import 'package:habitt/theme_provider.dart';
import 'package:habitt/user/country_service.dart';
import 'package:habitt/user/login_screen.dart';
import 'package:habitt/user/repository.dart';
import 'package:habitt/user/view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storage: localStorage),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(
            service: LocalStorageUserRepository(
              storage: localStorage,
              countryService: InMemoryCountryService(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitsViewModel(
            service: LocalStorageHabitsRepository(storage: localStorage),
          ),
        ),
      ],
      child: HabittApp(),
    ),
  );
}

class HabittApp extends StatelessWidget {
  const HabittApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Habitt',
      builder: FToastBuilder(),
      theme: themeProvider.mode == UI_THEME.DARK ? darkTheme : lightTheme,
      home: Consumer<UserViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoggedIn()) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
