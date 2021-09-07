import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'model/order_model.dart';
import 'objectbox.g.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  Store? _store;
  Box<OrderModel>? orderBox;
  StreamController streamController = StreamController(sync: true);

  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';

  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
      Sync.client(
        store,
        'ws://$syncServerIp:9999', // wss for SSL, ws for unencrypted traffic
        SyncCredentials.none(),
      ).start();

      orderBox = store.box<OrderModel>();
      final stream = _store?.watch<OrderModel>();
      streamController.add(stream);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Orders'),
      ),
      body: Center(
        child: StreamBuilder<void>(
            stream: streamController.stream,
            builder: (context, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasData) {
                List<OrderModel>? orders = orderBox?.getAll() ?? [];

                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final children = <Widget>[];
                    for (final item in orders[index].items) {
                      children.add(Text(item.itemName));
                    }
                    return Card(
                      color: orders[index].ordered
                          ? Colors.green
                          : Colors.redAccent,
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
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 5,
                  ),
                  itemCount: orders.length,
                );
              }

              if (snapshot.hasError) {
                return const Text("Error");
              }

              return const CircularProgressIndicator();
            }),
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
