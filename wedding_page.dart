import 'package:flutter/material.dart';

class WeddingPage extends StatelessWidget {
  const WeddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Text(
          "Wedding Planning",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title and Image
            Text(
              "Planning Your Dream Wedding",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Rounded Border Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
              child: Image.asset(
                'lib/images/wedding_guide.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Information Section
            Text(
              "Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Get started with the essentials for planning a perfect wedding, including budgeting, guest lists, and venue selection. A well-planned schedule ensures everything goes smoothly on your big day.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Suggestions Section
            Text(
              "Suggestions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "- Start early: Book your venue at least a year in advance.\n"
                  "- Keep your guest list small for an intimate celebration.\n"
                  "- Plan a theme that reflects your personality as a couple.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Inspiration Section
            Text(
              "Inspiration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Looking for wedding theme ideas? Consider outdoor rustic settings, glamorous ballroom affairs, or vintage-inspired decor. Find what resonates with your style to create lasting memories.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Guidance Section
            Text(
              "Guidance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "1. Set a budget and prioritize must-haves.\n"
                  "2. Choose reliable vendors.\n"
                  "3. Delegate tasks to friends and family.\n"
                  "4. Enjoy the planning process and stay flexible!",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
