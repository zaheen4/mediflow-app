import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_flow/utils/colors.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Voucher",style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Matching the aesthetic
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Information text
            Text(
              'Congratulations! You have successfully redeemed a voucher.',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Display the voucher code
            Text(
              'Your Voucher Code:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'DISCOUNT2025',
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Button to go back to Home Page
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Go back to the home page
              },
              child: Text("Back to Home",style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
