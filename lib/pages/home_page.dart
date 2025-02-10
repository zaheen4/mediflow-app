import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_flow/pages/cart_page.dart';
import 'package:medi_flow/pages/login_page.dart';
import 'package:medi_flow/pages/product_details_page.dart';
import 'package:medi_flow/pages/profile_page.dart'; // Import profile page
import 'package:medi_flow/pages/settings_page.dart'; // Import settings page
import 'package:medi_flow/pages/voucher_page.dart';
import 'package:provider/provider.dart';
import '../utils/button.dart';
import '../utils/colors.dart';
import '../models/shop.dart';
// ignore: unused_import
import '../models/product.dart';
import '../utils/product_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Global key for managing the Scaffold's state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Product Menu
  void navigateToProductDetails(int index) {
    final shop = context.read<Shop>();
    final productList = shop.productList;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: productList[index]),
        ));
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final productList = shop.productList;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey, // Assign the key to the scaffold
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.grey[900]),
          onPressed: () =>
              _scaffoldKey.currentState?.openDrawer(), // Open drawer using key
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72),
          child: Text(
            'MediFlow',
            style: TextStyle(color: Colors.grey[900]),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 8.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Text(
                'MediFlow Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage()), // Navigate to Profile Page
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage()), // Navigate to Settings Page
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                bool confirmLogout =
                    await _showLogoutConfirmationDialog(context);
                if (confirmLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false, // Clears all previous routes
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Promo banner
          Container(
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Get Discount Promo!',
                      style: GoogleFonts.dmSerifDisplay(
                          fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: MyButton(
                          text: "Redeem",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoucherPage()));
                          }),
                    ),
                  ],
                ),
                Image.asset('assets/icons/promo.png', height: 100),
              ],
            ),
          ),
          const SizedBox(height: 25),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Search here..",
                hintStyle: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Products",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) => Container(
                width: 250,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ProductTitle(
                    product: productList[index],
                    onTap: () => navigateToProductDetails(index)),
              ),
            ),
          ),
          const SizedBox(height: 100),
          // Container(
          //   decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
          //   margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          //   padding: const EdgeInsets.all(20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Image.asset("assets/products/Glucometer.png", height: 60),
          //           const SizedBox(width: 20),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text('Glucometer', style: GoogleFonts.dmSerifDisplay(fontSize: 18)),
          //               SizedBox(height: 10),
          //               Text('৳2500', style: TextStyle(color: Colors.grey[700])),
          //             ],
          //           ),
          //         ],
          //       ),
          //       Icon(Icons.favorite, color: Colors.grey, size: 28),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
