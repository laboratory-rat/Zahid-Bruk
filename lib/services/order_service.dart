import 'dart:async';

import 'dart:html' as http;
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:http/http.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Injectable()
class OrderService {
  final WCApi client = new WCApi();


  Future<HttpRequest> subscribe(String email){
    return null;
  }

  

  Future<HttpRequest> needConsultation(String name, String email, String tel, String q) async {
    var order = new WCOrderCreate();

    order.payment_method_title = 'Потрібна консультація';
    order.set_paid = "true";
    
    order.billing = new WCOrderUserData()
      ..email = email
      ..first_name = name
      ..phone = tel
      ..address_1 = q;

    order.line_items = new List<WCOrderProductData>()
      ..add(new WCOrderProductData()..product_id = 228..quantity = 1);


    var response = await client.postWC('orders', order);
    return response;
  }
}
