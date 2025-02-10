import 'package:flutter/material.dart';
import 'package:medi_flow/models/product.dart';
import 'package:medi_flow/models/shop.dart';
import 'package:medi_flow/utils/button.dart';
import 'package:medi_flow/utils/colors.dart';
import 'package:provider/provider.dart';
import 'checkout_page.dart'; // Import CheckoutPage

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Remove from cart
  void removeFromCart(Product product, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(product);
  }

  // Calculate total price
  double calculateTotalPrice(List<Product> cart) {
    double totalPrice = 0.0;
    for (var product in cart) {
      totalPrice += double.parse(product.price);
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("My Cart", style: TextStyle(color: Colors.white)),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            // Custom Cart
            Expanded(
                child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                  final Product product = value.cart[index];
                  final String productName = product.name;
                  final String productPrice = product.price;
                  return Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    ),
                    margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: ListTile(
                    title: Text(
                      productName,
                      style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      productPrice,
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: IconButton(
                      onPressed: () => removeFromCart(product, context),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      )),
                    ),
                  );
                  }),
            ),

            // Total Price
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total: ৳${calculateTotalPrice(value.cart).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 0),
                ),
              ),
            ),

            // Pay Button
            Padding(
              padding: const EdgeInsets.all(25.0),
              
              child: MyButton(
                
                text: "Pay Now",
                onTap: () {
                  // Calculate total price
                  double totalPrice = calculateTotalPrice(value.cart);

                  // Navigate to the CheckoutPage with the total price
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CheckoutPage(totalPrice: totalPrice)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
