import 'package:flutter/material.dart';
import 'package:medi_flow/models/product.dart';
import 'package:medi_flow/models/shop.dart';
import 'package:medi_flow/utils/button.dart';
import 'package:medi_flow/utils/colors.dart';
import 'package:provider/provider.dart';
import 'checkout_page.dart';  // Import CheckoutPage

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Remove from cart
  void removeFromCart(Product product, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(product);
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
                          color: Colors.grey[500], borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: ListTile(
                        title: Text(
                          productName,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          productPrice,
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                        trailing: IconButton(
                            onPressed: () => removeFromCart(product, context),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey[300],
                            )),
                      ),
                    );
                  }),
            ),
            // Pay Button
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: MyButton(
                text: "Pay Now",
                onTap: () {
                  // Navigate to the CheckoutPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()),
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
