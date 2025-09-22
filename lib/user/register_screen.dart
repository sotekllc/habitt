import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:habitt/user/view_model.dart';
import 'package:provider/provider.dart';

import 'package:habitt/habit/home_screen.dart';
import 'package:habitt/user/country_service.dart';
import 'package:habitt/user/login_screen.dart';
import 'package:habitt/theme.dart';
import 'package:habitt/widgets.dart';
import 'package:habitt/user/repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  double _age = 25; // Default age set to 25
  String _country = 'United States';
  List<String> _countries = [];
  List<String> selectedHabits = [];
  List<String> availableHabits = [
    'Wake Up Early',
    'Workout',
    'Drink Water',
    'Meditate',
    'Read a Book',
    'Practice Gratitude',
    'Sleep 8 Hours',
    'Eat Healthy',
    'Journal',
    'Walk 10,000 Steps',
  ];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    // TODO
    //  Bit of a code smell here. But we need a service call that doesn't
    //  require passing BuildContext.
    List<String> subsetCountries = InMemoryCountryService().getCountries();
    setState(() {
      _countries = subsetCountries;
      _countries.sort();
      _country = _countries.isNotEmpty ? _countries[0] : 'United States';
    });
  }

  void _register(BuildContext context) async {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      userViewModel.register({
        'username': _usernameController.text,
        'age': _age,
        'country': _country,
      });

      showToast(fToast, 'User registered, logging in...', Colors.greenAccent);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Error registering user: $e');
      showToast(fToast, e.toString(), Colors.redAccent);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text(
          'Register',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.primaryColorLight, theme.primaryColorDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: AppSizes.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField(
                    _usernameController,
                    'Username',
                    Icons.alternate_email,
                    theme,
                  ),
                  const SizedBox(height: 10),
                  buildInputField(
                    _passwordController,
                    'Password',
                    Icons.security_outlined,
                    theme,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Age: ${_age.round()}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
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
                  const Text(
                    'Select Your Habits',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: availableHabits.map((habit) {
                      final isSelected = selectedHabits.contains(habit);
                      return GestureDetector(
                        onTap: () {
                          selectedHabits.add(habit);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primaryColorLight
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: theme.primaryColorDark),
                          ),
                          child: Text(
                            habit,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : theme.primaryColorDark,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _register(context);
                        } else {
                          showToast(
                            fToast,
                            'Please fill in required fields!',
                            Colors.redAccent,
                          );
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
                        'Register',
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
      ),
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
