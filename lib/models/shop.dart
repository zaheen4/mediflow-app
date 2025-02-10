import 'package:flutter/cupertino.dart';

import 'product.dart';

class Shop extends ChangeNotifier {
  //product menu
  final List<Product> _productList = [
    //Glucometer
    Product(
        name: "Glucometer",
        price: "865",
        imagePath: "assets/products/Glucometer.png",
        rating: "4.2"),

    //ICUVentilator
    Product(
        name: "ICU Ventilator",
        price: "18286",
        imagePath: "assets/products/ICUVentilator.png",
        rating: "4.4"),
    //MultiParameterPatientMonitor
    Product(
        name: "Multi-Parameter Patient Monitor",
        price: "19213",
        imagePath: "assets/products/Multi-ParameterPatientMonitor.png",
        rating: "4.5"),
    //Nebulizer
    Product(
        name: "Nebulizer",
        price: "1423",
        imagePath: "assets/products/Nebulizer.png",
        rating: "4.6"),
    //pulseOximeter
    Product(
        name: "PulseOximeter",
        price: "633",
        imagePath: "assets/products/PulseOximeter.png",
        rating: "4.7"),
    //SteamAutoClaveSterilizer
    Product(
        name: "Steam Autoclave Sterilizer",
        price: "84230",
        imagePath: "assets/products/SteamAutoclaveSterilizer.png",
        rating: "4.2"),

    Product(
        name: "Defibrillator (AED)",
        price: "12069.04",
        imagePath: "assets/products/Defibrillator (AED).png",
        rating: "4.3"),

    Product(
        name: "Surgical Masks [Box]",
        price: "58.2",
        imagePath: "assets/products/Surgical Masks.png",
        rating: "4.0"),

    Product(
        name: "Oxygen Concentrator",
        price: "38889.10",
        imagePath: "assets/products/OxygenConcentrator.png",
        rating: "4.0"),

    Product(
        name: "Blood Pressure Monitor",
        price: "1462.92",
        imagePath: "assets/products/Blood Pressure Monitor.png",
        rating: "4.1"),
  ];

  // Customer cart
  final List<Product> _cart = [];

//getter methods
  List<Product> get productList => _productList;
  List<Product> get cart => _cart;

//add to cart
  void addToCart(Product productItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(productItem);
    }
  }

//remove from cart
  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }
}
