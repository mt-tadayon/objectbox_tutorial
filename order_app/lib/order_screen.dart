import 'package:flutter/material.dart';
import 'package:order_app/model/item_model.dart';
import 'package:order_app/model/order_model.dart';

import 'objectbox.g.dart';

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

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
    required this.title,
    required this.store,
    required this.orderBox,
    this.orderModel,
  }) : super(key: key);

  final String title;
  final Store? store;
  final Box<OrderModel> orderBox;
  final OrderModel? orderModel;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                              // TODO: Get from the current order the item and get the cound
                              // TODO: Save the current item on the Order
                              items[index].itemCount++;

                              widget.orderModel?.items.add(items[index]);
                              widget.orderBox.put(widget.orderModel!);

                              setState(() {});
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
                              widget.orderModel?.items.add(items[index]);
                              widget.orderBox.put(widget.orderModel!);
                              setState(() {});
                            },
                            child: const Icon(Icons.remove),
                          )
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 10,
                  );
                },
                itemCount: items.length,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.orderModel?.ordered = true;
              widget.orderModel?.items;
              widget.orderBox.put(widget.orderModel!);
              widget.orderBox.getAll();
              for (var element in items) {
                element.itemCount = 0;
              }
              Navigator.pop(context);
            },
            child: const Text('confirm'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
