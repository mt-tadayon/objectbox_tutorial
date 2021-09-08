
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO 6: Initialize store, orderBox and itemBox

  @override
  void initState() {
    super.initState();
    // TODO 7.Sync: Check for the correct IP Address for Sync Server
    // TODO 8: Open a store and connect Sync server
    // TODO 9: Open an orderBox from the store on OrderModel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order App Demo'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to our Restaurant',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO 11: Create a new OrderModel
                    // TODO 12: Navigate to the OrderScreen and pass in orderBox and orderModel
                  },
                  child: const Text('Create your order!'),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // TODO 10: Close the store
  }
}
