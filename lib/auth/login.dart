import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/forget_password.dart';
import 'package:fire_base/auth/repo/auth_repo.dart';
import 'package:fire_base/auth/signup.dart';
import 'package:fire_base/common_functions/show_flushbar.dart';
import 'package:fire_base/home/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool password = true;

  bool loading = false;

  login() async {
    setState(() {
      loading = true;
    });
    try {
      await AuthRepo.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      await AuthRepo.reloadData();

      if (AuthRepo.auth.currentUser!.emailVerified) {
        Get.offAll(
          const BottomNavigationBarScreen(),
        );
      }

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
                  child: const Image(
                    height: 150,
                    width: 150,
                    image: AssetImage("assets/design.gif"),
                  ),
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  obscureText: password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          password = !password;
                        });
                      },
                      icon: password == true
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(
                          const ForgetPassword(),
                        );
                      },
                      child: const Text("Forget Password"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          const Signup(),
                        );
                      },
                      child: const Text("Don't have an account ? Sign Up"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  // if condition - if else - inline if
                  child: loading == true
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
