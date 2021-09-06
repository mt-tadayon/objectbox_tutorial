import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'model/order_model.dart';
import 'objectbox.g.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  Store? _store;
  Box<OrderModel>? orderBox;
  bool hasBeenInitialized = false;
  StreamController streamController = StreamController(sync: true);

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
      final stream = _store?.watch<OrderModel>();
      stream?.listen((event) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel>? orders = orderBox?.getAll() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final children = <Widget>[];
            for (final item in orders[index].items) {
              children.add(Text(item.itemName));
            }
            return Card(
              color: orders[index].ordered ? Colors.green : Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Order no: ${orders[index].id}'),
                    ...children,
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 5,
          ),
          itemCount: orders.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _store?.close();
    streamController.close();
  }
}
