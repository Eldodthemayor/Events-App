import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/repo/auth_repo.dart';
import 'package:fire_base/common_functions/show_flushbar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  bool loading = false;

  forgetPassword() async {
    setState(() {
      loading = true;
    });
    try {
      await AuthRepo.sendPasswordResetEmail(emailController.text);

      showSuccess("Check your mail", context);

      setState(() {
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });

      showError(error.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    height: 150,
                    width: 150,
                    image: AssetImage("assets/design.gif"),
                  ),
                ),
                Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    forgetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  // if condition - if else - inline if
                  child: loading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Resend Email Verification"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// connect authentication - Firestore //
