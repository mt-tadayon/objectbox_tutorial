import 'package:objectbox/objectbox.dart';
import 'item_model.dart';

@Entity()
@Sync()
class OrderModel {
  int id = 0;
  bool ordered = false;

  @Backlink()
  final items = ToMany<ItemModel>();
}
