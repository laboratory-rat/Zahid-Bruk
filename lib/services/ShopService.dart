import '../domain/ShopItem.dart';
import 'dart:async';
import 'package:angular2/angular2.dart';
import '../mock/shop_items.dart';

@Injectable()
class ShopService{
    List<ShopItem> getShopItems() => mockShopItems;
    Future<List<ShopItem>> getShopItemsAsync() => new Future.delayed(const Duration(seconds: 2), getShopItems);
}