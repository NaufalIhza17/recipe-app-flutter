import 'package:flutter/material.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;
  Color darkBlueCustom = Color(0xFF003345);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueCustom,
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(),
                _loginForm(),
                _loginButton(),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _footer(),
        ),
      ],
    );
  }

  Widget _footer() {
    return Container(
      color: const Color.fromRGBO(0, 78, 105, 1),
      child: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "made by naufal ihza",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(171, 171, 171, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return const SizedBox(
      child: Column(
        children: [
          Text(
            "Recipe App",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(255, 122, 0, 1),
            ),
          ),
          Text(
            "Hello",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            "Welcome Back",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter username";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Username",
                hintText: "Enter your username",
                labelStyle: TextStyle(
                  color: Color.fromRGBO(77, 129, 148, 1),
                ),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(190, 190, 190, 1),
                ),
              ),
            ),
            TextFormField(
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 5) {
                  return "Enter a valid password";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                labelStyle: TextStyle(
                  color: Color.fromRGBO(77, 129, 148, 1),
                ),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(190, 190, 190, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(
              username!,
              password!,
            );
            if (result) {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Login Success',
                configuration: const IconConfiguration(
                  icon: Icons.check_circle,
                  color: Colors.white,
                ),
                maxWidth: 260,
                backgroundColor: Colors.green,
              );
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Login Failed',
                subtitle: 'Please Try Again',
                configuration: const IconConfiguration(icon: Icons.error),
                maxWidth: 260,
              );
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(77, 129, 148, 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: const Text(
          "login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
