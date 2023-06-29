import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;
  String? _loginErrorResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    child: Image.asset('assets/images/kfnBackground.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Login to your account",
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kPrimaryNavBarFontSize,
                ),
              ),
              const SizedBox(height: 60),
              if (_loginErrorResult != null)
                SizedBox(
                  width: 400,
                  child: Text(
                    _loginErrorResult!,
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
                  controller: _controllerEmail,
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
                  focusNode: _focusNodePassword,
                  obscureText: _obscurePassword,
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      var errorResult = await loginUser(
                          _controllerEmail.text, _controllerPassword.text);

                      if (errorResult != null) {
                        setState(() {
                          _loginErrorResult = errorResult;
                        });

                        return;
                      }

                      final response = await HttpClient.get('/v1/self');

                      if (!response.isSuccessful) {
                        FirebaseAuth.instance.signOut();
                        setState(() {
                          _loginErrorResult = 'An unknown error has occured';
                        });
                      }

                      if (_loginErrorResult == null) {
                        _formKey.currentState?.reset();
                        context.goNamed(RouteConstants.home);
                      }
                    }
                  },
                  style: elevatedButtonStyle,
                  child: const Text(
                    'Login',
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

  Future<String?> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown' &&
          (e.message?.contains('(auth/user-not-found)') ?? false)) {
        return 'User is not registered.';
      } else if (e.code == 'unknown' &&
          (e.message?.contains('(auth/wrong-password)') ?? false)) {
        return 'Incorrect password.';
      } else if (e.code == 'unknown' &&
          (e.message?.contains('(auth/too-many-requests)') ?? false)) {
        return 'Access to this account has been temporarily disabled due to many failed login attempts try again later.';
      }

      rethrow;
    }
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
