import 'package:flutter/material.dart';
import 'package:order_app/model/item_model.dart';
import 'package:order_app/model/order_model.dart';

import 'objectbox.g.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
    required this.orderBox,
    this.orderModel,
  }) : super(key: key);

  final Box<OrderModel> orderBox;
  final OrderModel? orderModel;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<ItemModel> items = [
    ItemModel(itemCount: 0, itemName: 'Pizza Salami'),
    ItemModel(itemCount: 0, itemName: 'Pizza Margaretta'),
    ItemModel(itemCount: 0, itemName: 'Spaghetti'),
    ItemModel(itemCount: 0, itemName: 'Lasagne'),
    ItemModel(itemCount: 0, itemName: 'Rice with Chicken'),
    ItemModel(itemCount: 0, itemName: 'Fried Noodle'),
    ItemModel(itemCount: 0, itemName: 'Fried Rice'),
    ItemModel(itemCount: 0, itemName: 'Salad'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order App Demo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[index].itemName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              items[index].itemCount++;
                              saveOrderModel(index);
                            },
                            child: const Icon(Icons.add),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              items[index].itemCount.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (items[index].itemCount == 0) return;
                              items[index].itemCount--;
                              saveOrderModel(index);
                            },
                            child: const Icon(Icons.remove),
                          )
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 10);
                },
                itemCount: items.length,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.orderModel?.ordered = true;
              widget.orderBox.put(widget.orderModel!);
              Navigator.pop(context);
            },
            child: const Text('confirm'),
          ),
        ],
      ),
    );
  }

  void saveOrderModel(int index) {
    widget.orderModel?.items.add(items[index]);
    widget.orderBox.put(widget.orderModel!);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
