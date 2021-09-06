import 'package:flutter/widgets.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_app/model/order_model.dart';
import 'package:order_app/order_screen.dart';

import 'model/item_model.dart';
import 'objectbox.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Store? _store;
  bool hasBeenInitialized = false;
  Box<OrderModel>? orderBox;
  Box<ItemModel>? itemBox;

  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';

  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
      setState(() {
        hasBeenInitialized = true;
      });
      SyncClient syncClient = Sync.client(
          store,
          'ws://$syncServerIp:9999', // wss for SSL, ws for unencrypted traffic
          SyncCredentials.none());
      syncClient.start();
      orderBox = store.box<OrderModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text('Welcome to our Restaurant'),
              ElevatedButton(
                onPressed: () {
                  final orderModel = OrderModel();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => OrderScreen(
                          title: widget.title,
                          store: _store,
                          orderBox: orderBox!,
                          orderModel: orderModel),
                    ),
                  );
                },
                child: const Text('Create your order!'),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _store?.close();
  }
}
