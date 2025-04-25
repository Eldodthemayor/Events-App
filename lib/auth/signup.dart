import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/login.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });

      Flushbar(
        message: "Successfully Registered",
        icon: Icon(
          Icons.check_circle,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.green,
      ).show(context);

      setState(() {
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });

      Flushbar(
        message: error.toString(),
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
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
                TextFormField(
                  obscureText: password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          password = !password;
                        });
                      },
                      icon: password == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        Login(),
                      );
                    },
                    child: Text("Already have an account: LogIn"),
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
                    minimumSize: Size(double.infinity, 50),
                  ),
                  // if condition - if else - inline if
                  child: loading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Sign up"),
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
