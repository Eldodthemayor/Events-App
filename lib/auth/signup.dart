import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/login.dart';
import 'package:fire_base/auth/repo/auth_repo.dart';
import 'package:fire_base/common_functions/show_flushbar.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

// OOP - Object Oriented Programming

// class - object

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool password = true;

  bool loading = false;

  signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await AuthRepo.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      await AuthRepo.sendEmailVerification();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthRepo.getUid())
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'uid': AuthRepo.getUid(),
      });

      showSuccess("Successfully Registered", context);

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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        const Login(),
                      );
                    },
                    child: const Text("Already have an account: LogIn"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    signUp();
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
                      : const Text("Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tables - Colums - Data

// Collections - documents - fields (data)

//   'name' : 'Mohamed'  //

// List - Map //

// users - uid - name - email - password
