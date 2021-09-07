import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  // TODO 13: Add parameters for OrderModel and OrderBox
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // TODO 14: Create a list with dishes -> ItemModel
  final items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order App Demo'),
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
              // TODO 18: Set ordered to true on orderModel
              // TODO 19: Save the orderModel into the orderBox
              Navigator.pop(context);
            },
            child: const Text('confirm'),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void saveOrderModel(int index) {
    // TODO 15: Add the item into the OrderModel items
    // TODO 16: Save the orderModel in the orderBox
    // TODO 17: Call set state to update the newest count
  }
}
