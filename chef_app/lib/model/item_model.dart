import 'package:objectbox/objectbox.dart';
import 'order_model.dart';

@Entity()
@Sync()
class ItemModel {
  int id = 0;
  String itemName;
  int itemCount;

  final orderModel = ToOne<OrderModel>();

  ItemModel({
    required this.itemCount,
    required this.itemName,
  });
}
