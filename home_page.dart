import 'package:event_management/birthday_page.dart';
import 'package:event_management/concert_page.dart';
import 'package:event_management/create_event.dart';
import 'package:event_management/wedding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'auth_page.dart';
import 'dashboard_page.dart';
import 'events_page.dart';
import 'bookings_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomePageContent(),
    DashboardPage(),
    BookingsPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      backgroundColor: Colors.white38,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black54,
        onTap: onItemTapped,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEvent()),
          );
        },
        label: const Text('Create Event'),
        icon: const Icon(Icons.add),
      )
          : null,
    );
  }
}

class HomePageContent extends StatelessWidget {
  final List<dynamic> carouselItems = [
    'lib/images/wedding__banner.png',
    'lib/images/Birthday_banner.png',
    'lib/images/coldplay.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hey ${FirebaseAuth.instance.currentUser!.email!}",
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Welcome to EventFlow",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_month, color: Colors.black),
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        hintText: 'Search your Event',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                      style: TextStyle(color: Colors.black),
                      onSubmitted: (value) {
                        // Implement search functionality here
                      },
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildEventTile(context, 'lib/images/wedding.jpeg', 'Wedding', WeddingPage()),
                        buildEventTile(context, 'lib/images/birthday.jpeg', 'Birthday', BirthdayPage()),
                        buildEventTile(context, 'lib/images/concert.jpg', 'Concert', ConcertPage()),
                        buildEventTile(context, 'lib/images/Events.jpeg', 'Events', EventsPage()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CarouselSlider.builder(
              itemCount: carouselItems.length,
              itemBuilder: (context, index, realIndex) {
                var item = carouselItems[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: item is String
                        ? Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                        : Container(
                      color: item,
                      child: Center(
                        child: Text(
                          'Event ${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading for Tasks
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildMenuTile('lib/images/wedding_food.png', 'Food Menu'),
                      buildMenuTile('lib/images/guest.png', 'Guest List'),
                      buildMenuTile('lib/images/vendor.png', 'Vendor'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vendors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildMenuTile('lib/images/decor.png', 'Decor'),
                      buildMenuTile('lib/images/makeup.png', 'Makeup'),
                      buildMenuTile('lib/images/caterers.png', 'Caterer'),
                      buildMenuTile('lib/images/clothing.png', 'Clothing'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEventTile(BuildContext context, String imagePath, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: buildEventContainer(imagePath, title),
      ),
    );
  }

  Widget buildEventContainer(String imagePath, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 76,
            width: 120,
          ),
          SizedBox(height: 2.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuTile(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.all(2.0), // Reduced padding for larger image appearance
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 90, // Adjusted size for better visibility
              width: 150,
            ),
            SizedBox(height: 2.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
