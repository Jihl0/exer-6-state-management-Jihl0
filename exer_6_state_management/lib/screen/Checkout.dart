import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Item Details"),
            addedItem(context),
            const Divider(height: 4, color: Colors.black),
            showButton(context),
          ],
        ));
  }

  Widget addedItem(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Expanded(
            child: Column(
            children: [Text('No Items to checkout!')],
          ))
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(products[index].name),
                      trailing: Text("${products[index].price}"));
                },
              )),
              totalCost()
            ],
          ));
  }

  Widget totalCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total Cost to pay: ${cart.cartTotal}");
    });
  }

  Widget showButton(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    if (products.isNotEmpty) {
      return ElevatedButton(
          onPressed: () {
            Navigator.pop(context, "Payment Successful!");
          },
          child: const Text("Pay Now!"));
    } else {
      return const Text("");
    }
  }
}
