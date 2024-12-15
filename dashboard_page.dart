import 'package:event_management/create_event.dart';
import 'package:event_management/events_page.dart';
import 'package:event_management/manage_task.dart';
import 'package:event_management/view_bookings.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final DateTime? selectedDate;

  const DashboardPage({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final remaining = selectedDate != null ? selectedDate!.difference(now) : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Text(
            'Dashboard',
            style: TextStyle(color: Colors.yellowAccent),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Your Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Countdown to the next event
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Countdown to Your Event:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (remaining != null && remaining.inSeconds > 0)
                    Text(
                      '${remaining.inDays} Days, ${remaining.inHours.remainder(24)} Hours, '
                          '${remaining.inMinutes.remainder(60)} Minutes, '
                          '${remaining.inSeconds.remainder(60)} Seconds',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    )
                  else
                    Text(
                      'No event date selected or the event has passed.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Quick Actions section
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  buildDashboardTile(
                    context,
                    icon: Icons.event,
                    color: Colors.purpleAccent,
                    title: 'Manage Task',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ManageTask()),
                      );
                    },
                  ),
                  buildDashboardTile(
                    context,
                    icon: Icons.book_online,
                    color: Colors.orangeAccent,
                    title: 'View Bookings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewBookings()),
                      );
                    },
                  ),
                  buildDashboardTile(
                    context,
                    icon: Icons.add_circle_outline,
                    color: Colors.greenAccent,
                    title: 'Create Event',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateEvent()),
                      );
                    },
                  ),
                  buildDashboardTile(
                    context,
                    icon: Icons.notifications,
                    color: Colors.redAccent,
                    title: 'Notifications',
                    onTap: () {
                      // Implement Notifications functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardTile(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
