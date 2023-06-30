import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeLastname = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerFirstname = TextEditingController();
  final TextEditingController _controllerLastname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  bool _obscurePassword = true;
  String? _registrationErrorResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(currentScreen: 'Register'),
              const SizedBox(height: 20),
              const Text(
                "Register",
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Create your account",
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kPrimaryNavBarFontSize,
                ),
              ),
              const SizedBox(height: 60),
              if (_registrationErrorResult != null)
                SizedBox(
                  width: 400,
                  child: Text(
                    _registrationErrorResult!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(Colors.red.shade800.value),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _controllerFirstname,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Firstname",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () => _focusNodeLastname.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter firstname.";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _controllerLastname,
                  focusNode: _focusNodeLastname,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Lastname",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter lastname.";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email address.";
                    } else if (!EmailValidator.validate(value)) {
                      return "Invalid email address.";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _controllerPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () =>
                      _focusNodeConfirmPassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 character.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _controllerConFirmPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodeConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    } else if (value != _controllerPassword.text) {
                      return "Password doesn't match.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _registrationErrorResult = null;
                    });

                    if (_formKey.currentState?.validate() ?? false) {
                      var errorResult = await registerUser(
                          _controllerFirstname.text,
                          _controllerLastname.text,
                          _controllerEmail.text,
                          _controllerPassword.text,
                          null);

                      setState(() {
                        _registrationErrorResult = errorResult;
                      });

                      if (_registrationErrorResult == null) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            width: 300,
                            backgroundColor: kPrimaryTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: const Center(
                                child: Text("Registered Successfully")),
                          ),
                        );

                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text);

                        final response = await HttpClient.get('/v1/self');

                        if (!response.isSuccessful) {
                          FirebaseAuth.instance.signOut();
                          setState(() {
                            _registrationErrorResult =
                                'An unknown error has occured';
                          });
                        }

                        _formKey.currentState?.reset();
                        // ignore: use_build_context_synchronously
                        context.goNamed(RouteConstants.home);
                      }
                    }
                  },
                  style: elevatedButtonStyle,
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: kPrimaryNavBarFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> registerUser(String firstname, String lastname, String email,
      String password, String? imageId) async {
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = result.user;

      if (user != null) {
        await user.updateDisplayName('${firstname}_+_${lastname}');
        if (imageId != null) await user.updatePhotoURL(imageId);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'unknown' &&
          (e.message?.contains('(auth/email-already-in-use)') ?? false)) {
        return 'The account already exists for that email.';
      }

      rethrow;
    }
  }

  @override
  void dispose() {
    _focusNodeLastname.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
