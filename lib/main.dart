import 'package:flutter/material.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Product data
  final List<Product> products = [
    Product(name: 'Product A', price: 10),
    Product(name: 'Product B', price: 15),
    Product(name: 'Product C', price: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the CartPage when "Go to Cart" is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    products: products,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductTile(
            product: product,
            onBuyPressed: () {
              // Increment the counter and show a dialog when Buy Now is pressed
              setState(() {
                product.incrementCounter();
                if (product.counter == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You\'ve bought 5 ${product.name}!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter = 0;

  Product({
    required this.name,
    required this.price,
  });

  void incrementCounter() {
    counter++;
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onBuyPressed;

  ProductTile({
    required this.product,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
      trailing: Column(
        children: [
          Text('Counter: ${product.counter}'),
          ElevatedButton(
            onPressed: onBuyPressed,
            child: Text('Buy Now'),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    int totalBought = 0;
    for (final product in products) {
      totalBought += product.counter;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products Bought: $totalBought'),
      ),
    );
  }
}
