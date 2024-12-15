import 'package:flutter/material.dart';

class Booking {
  final String eventName;
  final DateTime eventDate;
  final String status;

  Booking({required this.eventName, required this.eventDate, required this.status});
}

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final List<Booking> bookings = [
    Booking(eventName: 'Wedding Celebration', eventDate: DateTime.now().add(Duration(days: 10)), status: 'Confirmed'),
    Booking(eventName: 'Birthday Party', eventDate: DateTime.now().add(Duration(days: 5)), status: 'Pending'),
    Booking(eventName: 'Concert', eventDate: DateTime.now().add(Duration(days: 20)), status: 'Cancelled'),
  ];

  // Function to navigate to the Create Event page and wait for the result
  Future<void> _addNewBooking() async {
    final newBooking = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEventPage(),
      ),
    );

    // If a new booking was returned, add it to the list
    if (newBooking != null && newBooking is Booking) {
      setState(() {
        bookings.add(newBooking);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewBooking,
          ),
        ],
      ),
      body: bookings.isEmpty
          ? Center(child: Text('No bookings found.'))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(booking.eventName),
              subtitle: Text('Date: ${booking.eventDate.toLocal().toString().split(' ')[0]}\nStatus: ${booking.status}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    bookings.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${booking.eventName} deleted')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateEventPage extends StatelessWidget {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            TextField(
              controller: _eventStatusController,
              decoration: InputDecoration(labelText: 'Status (e.g., Confirmed, Pending, Cancelled)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final eventName = _eventNameController.text;
                final eventStatus = _eventStatusController.text;

                if (eventName.isNotEmpty && eventStatus.isNotEmpty) {
                  final newBooking = Booking(
                    eventName: eventName,
                    eventDate: DateTime.now().add(Duration(days: 7)), // Example date, can be customized
                    status: eventStatus,
                  );
                  Navigator.pop(context, newBooking); // Return the new booking to BookingsPage
                }
              },
              child: Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}
