import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:habitt/user/view_model.dart';
import 'package:provider/provider.dart';

import 'package:habitt/user/country_service.dart';
import 'package:habitt/user/model.dart';
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
  late TextEditingController _usernameController;

  double? _age = 25; // Default age set to 25
  String? _country = 'United States';
  String? _username = '';
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    _usernameController = new TextEditingController(
      text: userViewModel.getUser()?.username,
    );
    _fetchCountries();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _fetchCountries() async {
    // TODO
    //  Bit of a code smell here. But we need a service call that doesn't
    //  require passing BuildContext.
    List<String> subsetCountries = await HttpCountryService().getCountries();

    var userViewModel = Provider.of<UserViewModel>(context, listen: false);

    _age = userViewModel.getUser()?.age.toDouble();
    _username = userViewModel.getUser()?.username;

    setState(() {
      _countries = subsetCountries;
      _countries.sort();
      _country = _countries.isNotEmpty ? _countries[0] : 'United States';
    });
  }

  void _saveDetails(BuildContext context, Map<String, dynamic> formData) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      userViewModel.updateUserDetails(formData);

      showToast(fToast, 'User details saved', Colors.greenAccent);
    } catch (e) {
      print('Error saving user details: $e');
      showToast(fToast, e.toString(), Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userViewModel = Provider.of<UserViewModel>(context);

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
                Container(
                  decoration: formFieldDecoration,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: theme.primaryColorDark,
                      ),
                      hintText: 'Username',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                themeProvider.mode == UI_THEME.DARK
                    ? Text(
                        'Age: ${_age?.round()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        'Age: ${_age?.round()}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),

                Slider(
                  value: (_age ?? 25.0).toDouble(),
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

                themeProvider.mode == UI_THEME.DARK
                    ? ListTile(
                        leading: Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: Switch(
                          value: themeProvider.mode == UI_THEME.DARK,
                          onChanged: (bool newValue) {
                            if (newValue) {
                              themeProvider.switchToDarkMode();
                            } else {
                              themeProvider.switchToLightMode();
                            }
                          },
                        ),
                      )
                    : ListTile(
                        leading: Text("Dark Mode", style: titleStyle),
                        trailing: Switch(
                          value: themeProvider.mode == UI_THEME.DARK,
                          onChanged: (bool newValue) {
                            if (newValue) {
                              themeProvider.switchToDarkMode();
                            } else {
                              themeProvider.switchToLightMode();
                            }
                          },
                        ),
                      ),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> _formData = {
                          'username': _usernameController.text,
                          'age': _age?.toInt(),
                          'country': _country,
                          'password': userViewModel.getUser()?.password,
                        };
                        _saveDetails(context, _formData);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColorDark,
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
