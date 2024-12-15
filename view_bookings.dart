import 'package:flutter/material.dart';

class ViewBookings extends StatefulWidget {
  const ViewBookings({super.key});

  @override
  State<ViewBookings> createState() => _ViewBookingsState();
}

class _ViewBookingsState extends State<ViewBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Bookings'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('All your bookings in one place',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
