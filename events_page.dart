import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Text(
          'Formal Event Planning',
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
              "Organizing a Memorable Formal Event",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('lib/images/Event_guide.png',
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
              "Planning a formal event involves attention to detail and elegance. "
                  "From securing a venue to arranging seating and catering, each component "
                  "should reflect the tone of sophistication required for the occasion.",
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
              "- Select a venue that matches the event's theme and formality.\n"
                  "- Consider a dress code to maintain the event’s sophisticated atmosphere.\n"
                  "- Arrange for professional photography to capture memorable moments.",
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
              "Explore decor themes such as black-tie, vintage glam, or modern elegance. "
                  "Incorporate floral arrangements, ambient lighting, and live music to elevate "
                  "the atmosphere. Look online for creative inspiration tailored to formal events.",
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
              "1. Create a timeline for the event, including key moments like speeches.\n"
                  "2. Coordinate with vendors to ensure seamless service on the day.\n"
                  "3. Plan a seating chart to facilitate social connections among guests.\n"
                  "4. Arrange for valet parking or clear directions if the venue is remote.\n"
                  "5. Ensure a backup plan for weather if it's an outdoor formal event.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
