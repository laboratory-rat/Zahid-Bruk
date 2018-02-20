import '../components/page_product/page_product.dart';
import 'dart:async';

import 'dart:html' as http;
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:http/http.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Injectable()
class OrderService {
  final WCApi client = new WCApi();

  final String streetId = '260';
  final String roadId = '263';
  final String delivery = '1';

  Future<HttpRequest> subscribe(String email) {
    return null;
  }

  Future<HttpRequest> order(
      OrderData data, String productId, String variationId) async {
    var order = new WCOrderCreate();

    // add products
    var orderItems = new List<WCOrderProductData>();

    // main product
    var mainOrder = new WCOrderProductData();

    int q = int.parse(data.count.toString(), onError: (error) {
      return 1;
    });

    mainOrder
      ..product_id = productId
      ..quantity = q;

    if (variationId != null && variationId.isNotEmpty) {
      var variation = int.parse(variationId, onError: (_) {
        return null;
      });

      if (variation != null) {
        mainOrder.variation_id = variation;
      }
    }
    orderItems.add(mainOrder);

    // for street
    if (data.sidewalk) {
      orderItems.add(new WCOrderProductData()
        ..product_id = streetId
        ..quantity = 1);
    }

    // for road
    if (data.car) {
      orderItems.add(new WCOrderProductData()
        ..product_id = roadId
        ..quantity = 1);
    }

    order.line_items = orderItems;

    // user data
    var user = new WCOrderUserData()
      ..first_name = data.name
      ..phone = data.tel
      ..second_name = ""
      ..address_2 = ""
      ..state = ""
      ..postcode = "";

    if (data.city != null && data.city.isNotEmpty) {
      user.city = data.city;
    } else {
      user.city = '';
    }

    if (data.address != null && data.address.isNotEmpty) {
      user.address_1 = data.address;
    } else {
      user.address_1 = '';
    }

    if (data.email != null && data.email.isNotEmpty) {
      user.email = data.email;
    } else {
      user.email = 'noemail@email.com';
    }

    order.billing = user;
    order.shipping = user;

    order.shipping_lines = new List<WCOrderShippingLines>();

    // delivery
    if (data.delivery) {
      order.shipping_lines.add(new WCOrderShippingLines()
        ..method_id = delivery
        ..method_title = "Common delivery"
        ..total = "1");
    }

    return await client.postWC('orders', order);
  }

  Future<HttpRequest> needConsultation(
      String name, String email, String tel, String q) async {
    var order = new WCOrderCreate();

    order.payment_method_title = 'Потрібна консультація';
    order.set_paid = "true";

    order.billing = new WCOrderUserData()
      ..email = email
      ..first_name = name
      ..phone = tel
      ..address_1 = q
      ..address_2 = ""
      ..city = ""
      ..second_name = ''
      ..postcode = ''
      ..state = '';

    order.line_items = new List<WCOrderProductData>()
      ..add(new WCOrderProductData()
        ..product_id = "228"
        ..quantity = 1);

    var response = await client.postWC('orders', order);
    return response;
  }
}
