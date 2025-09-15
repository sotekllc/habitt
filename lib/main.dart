import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

import 'package:habitt/habit/home_screen.dart';
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
          create: (_) => UserViewModel(
            service: InMemoryUserRepository(
              storage: localStorage,
              countryService: InMemoryCountryService(),
            ),
          ),
        ),
      ],
      child: HabittApp(),
    ),
  );
  // runApp(const MyApp());
}

class HabittApp extends StatelessWidget {
  const HabittApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // TODO
      //  Read from ConfigurationProvider for light vs dark theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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
