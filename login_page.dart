import 'package:event_management/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/my_textfield.dart';
import 'components/sqaure_tile.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editinf controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async{

    //show loading circle
    showDialog(
      context: context,
      builder:(context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      //Wrong Email
      Navigator.pop(context);
      if(e.code == 'user-not-found'){
        //show error to user
        wrongEmailMessage();
      }

      //Wring passwrid
      else if(e.code == 'wrong-password'){
        //show errir to user
        wrongPasswordMessage();
      }
    }


  }

  //Wriong email message popup
  void wrongEmailMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  void wrongPasswordMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4F4), // Lighter shade of grey
      resizeToAvoidBottomInset: true, // Allows the layout to resize when the keyboard shows up
      body: SafeArea(
        child: SingleChildScrollView( // Enables scrolling to avoid overflow
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center align the screen for various screen sizes
              children: [
                const SizedBox(height: 50),

                const Icon(
                  Icons.lock,
                  size: 80,
                ),

                const SizedBox(height: 50),
                const Text(
                  'Welcome back, you\'ve been missed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // Email text field (commented out for now)
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // Password text field (commented out for now)
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Forgot password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),


                // Sign button (commented out for now)
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 50),

                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Google + Apple sign-in buttons (commented out for now)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),

                const SizedBox(height: 50),

                // Not a member? Register
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

