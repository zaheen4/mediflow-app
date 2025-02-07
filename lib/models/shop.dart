import 'package:flutter/cupertino.dart';

import 'product.dart';


class Shop extends ChangeNotifier{
  //product menu
  final List<Product> _productList = [
    //Glucometer
    Product(name: "Glucometer",
        price: "2500",
        imagePath: "assets/products/Glucometer.png",
        rating: "4.9"),

    //ICUVentilator
    Product(
        name: "ICU Ventilator",
        price: "2500",
        imagePath: "assets/products/ICUVentilator.png",
        rating: "4.9"),
    //MultiParameterPatientMonitor
    Product(
        name: "Multi-Parameter Patient Monitor",
        price: "2500",
        imagePath: "assets/products/Multi-ParameterPatientMonitor.png",
        rating: "4.9"),
    //Nebulizer
    Product(
        name: "Nebulizer",
        price: "2500",
        imagePath: "assets/products/Nebulizer.png",
        rating: "4.9"),
    //pulseOximeter
    Product(
        name: "PulseOximeter",
        price: "2500",
        imagePath: "assets/products/PulseOximeter.png",
        rating: "4.9"),
    //SteamAutoClaveSterilizer
    Product(
        name: "Steam Autoclave Sterilizer",
        price: "2500",
        imagePath: "assets/products/SteamAutoclaveSterilizer.png",
        rating: "4.9"),
  ];

  // Customer cart
List<Product> _cart = [];

//getter methods
List<Product> get productList => _productList;
List<Product> get cart => _cart;

//add to cart
void addToCart(Product productItem, int quantity){
  for(int i = 0; i<quantity; i++){
    _cart.add(productItem);
  }
}

//remove from cart
void removeFromCart(Product product){
  _cart.remove(product);
  notifyListeners();
}

}