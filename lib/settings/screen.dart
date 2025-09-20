import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:habitt/user/view_model.dart';
import 'package:provider/provider.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';
import 'package:habitt/theme_provider.dart';
import 'package:habitt/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  // bool _isDarkMode = false;
  double _age = 25; // Default age set to 25
  String _country = 'United States';
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // var themeProvider = Provider.of<ThemeProvider>(context);
    // _isDarkMode = themeProvider.mode == UI_THEME.DARK;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _saveDetails(BuildContext context, Map<String, dynamic> formData) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      userViewModel.updateUserDetails(formData);

      showToast(fToast, 'User registered, logging in...', Colors.greenAccent);
    } catch (e) {
      print('Error saving user details: $e');
      showToast(fToast, e.toString(), Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: AppSizes.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildInputField(
                  _usernameController,
                  'Username',
                  Icons.alternate_email,
                  theme,
                ),

                const SizedBox(height: 10),

                Slider(
                  value: _age,
                  min: 21,
                  max: 100,
                  divisions: 79,
                  activeColor: theme.primaryColorDark,
                  inactiveColor: theme.primaryColorLight,
                  onChanged: (double value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                _buildCountryDropdown(theme),

                const SizedBox(height: 10),

                ListTile(
                  leading: Text("Dark Mode", style: titleStyle),
                  trailing: Switch(
                    value: themeProvider.mode == UI_THEME.DARK,
                    onChanged: (bool newValue) {
                      // setState(() {
                      //   _isDarkMode = newValue;
                      // });

                      if (newValue) {
                        themeProvider.switchToDarkMode();
                      } else {
                        themeProvider.switchToLightMode();
                      }

                      // setState(() {
                      //   _isDarkMode = themeProvider.mode == UI_THEME.DARK;
                      // });
                    },
                  ),
                ),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> _formData = {
                          'username': _usernameController.text,
                          'age': _age,
                          'country': _country,
                        };
                        _saveDetails(context, _formData);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }

  Widget _buildCountryDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: formFieldDecoration,
      child: DropdownButton<String>(
        value: _country,
        icon: Icon(Icons.arrow_drop_down, color: theme.primaryColorDark),
        isExpanded: true,
        underline: const SizedBox(),
        items: _countries.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _country = newValue!;
          });
        },
      ),
    );
  }
}
