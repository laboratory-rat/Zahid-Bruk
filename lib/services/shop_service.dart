import '../components/ext/select_material/select_material.dart';
import '../configs/main_config.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Injectable()
class ShopService {
  final WCApi client = new WCApi();

  Future<List<WPCategory>> getAllCategories() async {
    var response = await client.getWC('products/categories', null);

    List<WPCategory> result = [];
    JSON.decode(response).forEach((c) {
      result.add(new WPCategory()..fromMap(c));
    });

    return result;
  }

  Future<WCProduct> getProductById(int id) async {
    var response = await client.getWC('products/$id');
    if (response == null) return null;
    return new WCProduct()..fromMap(JSON.decode(response));
  }

  Future<List<WCProduct>> getProductVariations(int id) async {
    var response = await client.getWC('products/$id/variations');
    if (response == null) return new List<WCProduct>();

    return JSON.decode(response).map((x) => new WCProduct()..fromMap(x)).toList();
  }

  Future<List<WCProduct>> getProductsByParams(String orderBy, bool isDesc, [int category, int minPrice, int maxPrice, bool featured, bool onSale]) async {
    List<ApiParam> params = new List<ApiParam>();

    params.add(new ApiParam(param: 'orderby', value: orderBy));

    if (isDesc) {
      params.add(new ApiParam(param: 'order', value: 'desc'));
    } else {
      params.add(new ApiParam(param: 'order', value: 'asc'));
    }

    if (category != null) {
      params.add(new ApiParam(param: 'category', value: category.toString()));
    }

    if (minPrice != null) {
      params.add(new ApiParam(param: 'min_price', value: minPrice.toString()));
    }

    if (maxPrice != null) {
      params.add(new ApiParam(param: 'max_price', value: maxPrice.toString()));
    }

    if (featured) {
      params.add(new ApiParam(param: 'featured', value: 'true'));
    }

    if (onSale) {
      params.add(new ApiParam(param: 'on_sale', value: 'true'));
    }

    params.add(new ApiParam(param: 'status', value: 'publish'));

    var response = await client.getWC('products', params);

    List<WCProduct> result = [];
    JSON.decode(response).forEach((r) {
      result.add(new WCProduct()..fromMap(r));
    });

    return result;
  }

  Future<int> getCount([int category, int tag]) async {
    var parameters = [];

    if (category != null) {
      parameters.add(new ApiParam(param: 'category', value: category.toString()));
    }

    if (tag != null) {
      parameters.add(new ApiParam(param: 'tag', value: tag.toString()));
    }

    parameters.add(new ApiParam(param: 'status', value: 'publish'));
    

    var response = await client.getWC('products/count', parameters);
    return JSON.decode(response).count;
  }

  Future<List<WCProduct>> getProductsByCategory(int category, [List<ApiParam> params]) async {
    if (params == null) params = [];

    params.add(new ApiParam(param: 'category', value: category.toString()));
    params.add(new ApiParam(param: 'status', value: 'publish'));

    var response = await client.getWC('products', params);

    List<WCProduct> result = [];
    var target = JSON.decode(response).toList();
    for (var x in target) {
      result.add(new WCProduct()..fromMap(x));
    }

    return result;
  }

  Future<List<WCProduct>> getProductsCustom(List<ApiParam> params) async {
    if (params == null || params.length < 1) return new List<WCProduct>();

    params.add(new ApiParam(param: 'status', value: 'publish'));

    var response = await client.getWC('products', params);

    return JSON.decode(response).map((x) => new WCProduct()..fromMap(x)).toList();
  }

  Future<List<WCProduct>> getProducts(int page, [int perPage = 20]) async {
    var response = await client.getWC('products', [new ApiParam(param: 'page', value: page.toString()), new ApiParam(param: 'status', value: 'publish')]);

    if (response == null) return null;

    List<WCProduct> result = [];
    JSON.decode(response).forEach((p) {
      result.add(new WCProduct()..fromMap(p));
    });

    return result;
  }

  Future<List<WCProduct>> getProductsBatch(List<String> ids) async {
    var value = '(0,';
    for (int i = 0; i < ids.length; i++) {
      value += ids[i];

      if (i + 1 < ids.length) value += ',';
    }

    value += ')';

    var response = await client.getWC('products', [new ApiParam(param: 'include', value: value)]);

    if (response == null) return new List<WCProduct>();
    return JSON.decode(response).map((x) => new WCProduct()..fromMap(x));
  }

  Future<List<WPTag>> getAllTags() async {
    List<WPTag> result = new List<WPTag>();
    var response = await client.getWC('products/tags');

    if (response == null) return result;

    JSON.decode(response).forEach((t) {
      result.add(new WPTag()..fromMap(t));
    });

    return result;
  }
}

class ApiOrderBy extends ISelectMaterialElement {
  String title = '';
  String value = '';
  bool isDesc = false;

  @override
  String getLabel() {
    return title;
  }

  @override
  String getId() {
    return '-1';
  }
}
