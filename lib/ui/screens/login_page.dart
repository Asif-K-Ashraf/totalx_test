import 'package:flutter/material.dart';
import 'package:totalx_test/services/auth_services.dart';
import 'package:totalx_test/ui/screens/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 20),
          child: Text(
            "Login or create an Account",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome \nTOTAL-X",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            Image(image: AssetImage('assets/login_image.png')),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () async {
                  final user = await _auth.signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Login Failed")));
                  }
                },
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/google_logo.png'),
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text("Sign in with Google"),
                  ],
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("By continuing, I agree to "),

                GestureDetector(
                  onTap: () {
                    // open terms
                  },
                  child: Text(
                    "Terms and condition",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),

                Text(" & "),

                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "privacy policy",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
