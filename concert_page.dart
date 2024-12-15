import 'package:flutter/material.dart';

class ConcertPage extends StatelessWidget {
  const ConcertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Text(
          'Concert Planning',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Image
            Text(
              "Planning an Unforgettable Concert",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
            child: Image.asset('lib/images/concert_guide.png',
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
              "Planning a concert requires detailed preparation to create an enjoyable "
                  "experience for both the performers and audience. Start with selecting the "
                  "right venue, setting a budget, and securing permits if necessary.",
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
              "- Choose a lineup that appeals to your target audience.\n"
                  "- Ensure that sound and lighting systems are set up properly.\n"
                  "- Arrange food and beverage vendors if the venue allows.",
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
              "Consider unique concert themes like acoustic nights, open-air setups, or "
                  "collaborations with local artists. Social media platforms are a great source "
                  "for discovering new ideas to make your concert stand out.",
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
              "1. Plan a realistic budget and monitor expenses closely.\n"
                  "2. Coordinate with performers, vendors, and security well ahead of time.\n"
                  "3. Promote the concert through social media, flyers, and email.\n"
                  "4. Conduct sound checks before the event.\n"
                  "5. Keep emergency contacts and a first-aid kit handy.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
