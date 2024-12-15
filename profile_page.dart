import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_page.dart';

class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser; // Fetch the current user

  @override
  Widget build(BuildContext context) {
    // Check if user is null (not signed in)
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No user is signed in.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue, // Ensure this is a visible color
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Ensure the icon color is visible
            onPressed: () async {
              // Handle Logout action
              await FirebaseAuth.instance.signOut(); // Sign out
              // Navigate back to the AuthPage (login page)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthPage(), // Navigate to AuthPage after logout
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 70,
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : AssetImage("lib/images/danish.png"),
            ),

            SizedBox(height: 16),
            // User Information
            Text(
              user?.displayName ?? 'User Name', // Display name or fallback text
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              user?.email ?? 'Email not available', // User's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              user?.phoneNumber ?? '+1 234 567 890', // Use user's phone number if available
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Marriage Freak | Flutter Nerd | Tech Sucker',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(
                  context,
                  icon: Icons.edit,
                  label: 'Edit',
                  onTap: () {
                    // Handle Edit action
                  },
                ),
                buildActionButton(
                  context,
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    // Handle Settings action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Icon(icon, color: Colors.blueAccent),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
