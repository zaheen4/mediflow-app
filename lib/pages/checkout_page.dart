import 'package:flutter/material.dart';
import 'package:medi_flow/utils/colors.dart';  // Assuming you have a color file for consistent styling

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout", style: TextStyle(color: Colors.white)),
        backgroundColor: secondaryColor, // Use the same secondary color as HomePage
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add some space and style to the confirmation text
            Text(
              "Please confirm your order",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800], // Use a consistent color
              ),
            ),
            SizedBox(height: 30),

            // Container for showing order summary (optional: can list items, etc.)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // You can list items here dynamically if needed, for now it's a placeholder
                  SizedBox(height: 10),
                  Text("Total Price: ৳5000", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Confirm Order button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                // Show confirmation popup
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Order Confirmed"),
                      content: Text("Your order has been confirmed!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);  // Close the dialog
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Center(child: Text("Confirm Order", style: TextStyle(color:Colors.white,fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
