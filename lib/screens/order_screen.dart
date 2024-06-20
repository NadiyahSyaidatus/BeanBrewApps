import 'package:flutter/material.dart';
import 'package:beanbrewapps/models/order.dart';
import 'package:provider/provider.dart';
import 'package:beanbrewapps/providers/product_provider.dart';
import 'tracking_screen.dart'; // Import TrackingScreen

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
        backgroundColor: Colors.brown,
      ),
      body: Consumer<ProductDataProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.orders.isEmpty) {
            return Center(
              child: Text('Tidak ada pesanan.'),
            );
          }

          return ListView.builder(
            itemCount: productProvider.orders.length,
            itemBuilder: (context, index) {
              final order = productProvider.orders[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            order.product.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.product.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Jumlah: ${order.quantity}'),
                                Text('Total: Rp ${order.totalPrice}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackingScreen(), // Navigasi ke TrackingScreen
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.brown,
                        ),
                        child: Text('Lacak Pengiriman'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
