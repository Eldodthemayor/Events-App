import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterNewPasswordController = TextEditingController();

  bool loading = false;
  bool checkOldPasswordState = true;

  updatePassword() async {
    setState(() {
      loading = true;
    });

    try {
      checkOldPasswordState = await checkOldPassword();
      if (checkOldPasswordState == true) {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(
          newPasswordController.text,
        )
            .whenComplete(() {
          setState(() {
            loading = false;
          });
          Flushbar(
            message: 'Password Updated Successfully',
            icon: Icon(
              Icons.check_circle,
              size: 28.0,
              color: Colors.green,
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.green,
          ).show(context);
        });
      } else {
        setState(() {
          loading = false;
        });
        Flushbar(
          message: 'old password is incorrect',
          icon: Icon(
            Icons.error,
            size: 28.0,
            color: Colors.red,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.red,
        ).show(context);
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      Flushbar(
        message: e.toString(),
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

  Future<bool> checkOldPassword() async {
    try {
      var loginResult =
          await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: FirebaseAuth.instance.currentUser!.email!,
          password: oldPasswordController.text,
        ),
      );
      return loginResult.user != null ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "To Change Password Please fill in the form below and click save password",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: oldPasswordController,
              decoration: InputDecoration(
                hintText: 'enter your old password',
                labelText: 'Old Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                hintText: 'enter your new password',
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: reEnterNewPasswordController,
              decoration: InputDecoration(
                hintText: 're-enter new password',
                labelText: 'Re-Enter new Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            FlutterPwValidator(
              controller: newPasswordController,
              minLength: 6,
              lowercaseCharCount: 2,
              defaultColor: Colors.black,
              width: 400,
              height: 180,
              onSuccess: () {},
              onFail: () {},
            ),
            ElevatedButton(
              onPressed: () {
                updatePassword();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: loading == true
                  ? CircularProgressIndicator()
                  : Text("Save Password"),
            ),
          ],
        ),
      ),
    );
  }
}
