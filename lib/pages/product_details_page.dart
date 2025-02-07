import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_flow/models/shop.dart';
import 'package:medi_flow/utils/button.dart';
import 'package:medi_flow/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  //quantity
  int quantityCount = 0;

  //decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  //increment quantity
  void incrementQuantity() {
    setState(() {
      if (quantityCount < 100) {
        quantityCount++;
      }
    });
  }

  void addToCart() {
    //only add to cart if there is something in the cart
    if (quantityCount > 0) {
      //access to the shop
      final shop = context.read<Shop>();

      //add to the cart
      shop.addToCart(widget.product, quantityCount);
      //let the user know it was successful
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Text("Successfully added to cart",style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.bold),),
          actions: [IconButton(onPressed: () {
            // pop once to remove dialog box
            Navigator.pop(context);
            //pop again to go previous screen
            Navigator.pop(context);
          }, icon: const Icon(Icons.done))],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          //ListView of the product details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //image
                  Image.asset(
                    widget.product.imagePath,
                    height: 200,
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  //rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),

                      const SizedBox(width: 5),
                      //Rating number
                      Text(
                        widget.product.rating,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //product name
                  Text(
                    widget.product.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "It is a device that measures blood glucose levels, typically used by people with diabetes to monitor and manage their condition. It works by testing a small blood sample and providing a glucose reading.",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 14, height: 2),
                  )
                ],
              ),
            ),
          ),
          //price+ quantity + add to cart button
          Container(
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //price
                          Text(
                            "\৳" + widget.product.price,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      //quantity

                      Row(
                        children: [
                          //minus button
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryColor, shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: decrementQuantity,
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                            ),
                          ),

                          //quantity count
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                quantityCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          //plus button
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryColor, shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: incrementQuantity,
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Add to cart Button
                  MyButton(text: "Add to Cart", onTap: addToCart),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
