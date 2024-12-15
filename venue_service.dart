import 'package:event_management/budget.dart';
import 'package:flutter/material.dart';

class VenueService extends StatefulWidget {
  const VenueService({super.key});

  @override
  _VenueServiceState createState() => _VenueServiceState();
}

class _VenueServiceState extends State<VenueService> {
  bool isCateringSelected = false;
  bool isPhotographySelected = false;
  bool isDecorationSelected = false;

  // Venue costs
  final int cateringCost = 700000;
  final int photographyCost = 150000;
  final int decorationCost = 200000;

  // Venue costs for each selected venue
  final Map<String, int> venueCosts = {
    'Jaipur': 500000,
    'Goa': 800000,
    'Jaisalmer': 600000,
    'Mussorie': 400000,
  };

  int totalBudget = 0;
  String selectedVenue = '';

  int get totalCost {
    int cost = 0;
    if (isCateringSelected) cost += cateringCost;
    if (isPhotographySelected) cost += photographyCost;
    if (isDecorationSelected) cost += decorationCost;
    if (selectedVenue.isNotEmpty) cost += venueCosts[selectedVenue] ?? 0;
    return cost;
  }

  // Method to show venue details
  void _showVenueDetails(String title, String imagePath, String description, int cost) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 8),
                Text('Cost: ₹$cost', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Select Venue'),
              onPressed: () {
                setState(() {
                  selectedVenue = title; // Set the selected venue
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue & Services'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Venue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildEventTile(context, 'lib/images/jaipur.png', 'Jaipur',
                      'A beautiful city known for its rich history and stunning architecture.',
                          () {
                        _showVenueDetails('Jaipur', 'lib/images/jaipur.png',
                            'Jaipur is famous for its palaces, forts, and vibrant culture.', venueCosts['Jaipur']!);
                      }),
                  buildEventTile(context, 'lib/images/goa.png', 'Goa',
                      'A tropical paradise with beautiful beaches.', () {
                        _showVenueDetails('Goa', 'lib/images/goa.png',
                            'Goa is known for its stunning beaches, vibrant nightlife, and Portuguese heritage.', venueCosts['Goa']!);
                      }),
                  buildEventTile(
                      context,
                      'lib/images/jaisalmer.png',
                      'Jaisalmer',
                      'The Golden City, famous for its desert and forts.', () {
                    _showVenueDetails('Jaisalmer', 'lib/images/jaisalmer.png',
                        'Jaisalmer is known for its stunning forts and desert landscape.', venueCosts['Jaisalmer']!);
                  }),
                  buildEventTile(context, 'lib/images/mussorie.png', 'Mussorie',
                      'A charming hill station with breathtaking views.', () {
                        _showVenueDetails('Mussorie', 'lib/images/mussorie.png',
                            'Mussorie is known for its picturesque scenery and pleasant weather.', venueCosts['Mussorie']!);
                      }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Catering - ₹7,00,000'),
                  value: isCateringSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      isCateringSelected = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Photography - ₹1,50,000'),
                  value: isPhotographySelected,
                  onChanged: (bool? value) {
                    setState(() {
                      isPhotographySelected = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Decoration - ₹2,00,000'),
                  value: isDecorationSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      isDecorationSelected = value ?? false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Enter Your Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  totalBudget = int.tryParse(value) ?? 0; // Update total budget based on user input
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Budget',
                prefixIcon: const Icon(Icons.money),
              ),
            ),
            Text(
              'Don’t worry if you feel that you\'d miss out on a service we\'ve got you covered. You can now customize according to your Budget...',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Budget(
                      totalBudget: totalBudget,
                      totalCost: totalCost,
                      isPhotographySelected: isPhotographySelected, // Pass this parameter
                    ),
                  ),
                );
              },
              child: Center(child: const Text('Proceed to Review', style: TextStyle(color: Colors.blueAccent))),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventTile(BuildContext context, String imagePath, String title,
      String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 149,
              width: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
