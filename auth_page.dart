import 'package:event_management/home_page.dart';
import 'package:event_management/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
   const AuthPage({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: StreamBuilder<User?>(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot){
           //is user loggef in?
           if(snapshot.hasData){
             return HomePage();
           }

           else{
             return LoginPage();
           }
           //not logged in?

         },
       ),
     );
   }
 }
