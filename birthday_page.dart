import 'package:flutter/material.dart';

class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Text(
          'Birthday Planning',
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
              "Planning the Next Special Birthday",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
              child: Image.asset(
                'lib/images/birthday_guide.png',
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
              "Get started with the essentials for planning a special birthday, "
                  "including budgeting, guest lists, and venue selection. A well-planned "
                  "schedule ensures everything goes smoothly on your big day.",
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
              "- Choose a theme that suits the birthday person's interests.\n"
                  "- Consider a personalized cake to make the day even more special.\n"
                  "- Plan fun activities or games suitable for the guests attending.",
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
              "Look for unique ideas, such as outdoor picnics, beach parties, "
                  "or even a cozy movie night. Pinterest and Instagram can be great sources "
                  "of inspiration for creating memorable birthday experiences.",
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
              "1. Set a budget and stick to it.\n"
                  "2. Organize a guest list and send invitations early.\n"
                  "3. Coordinate with any vendors or caterers well in advance.\n"
                  "4. Create a checklist to track all the details.\n"
                  "5. Remember to relax and enjoy the celebration!",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


