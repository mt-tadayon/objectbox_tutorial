import 'package:objectbox/objectbox.dart';
import 'package:order_app/model/item_model.dart';

@Entity()
@Sync()
class OrderModel {
  int id = 0;
  bool ordered = false;

  @Backlink()
  final items = ToMany<ItemModel>();
}
