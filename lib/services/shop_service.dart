import '../configs/main_config.dart';
import 'dart:async';
import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';


@Injectable()
class ShopService{
    final WCApi client = new WCApi();
    static Map categories = {};
    static bool isInit = false;
    ShopService(){
        if(!isInit)
        {
            categories['paving'] = mainConfig['wp']['categories']['paving'];
            isInit = true;
        }
    }

    Future<WCProduct> getProductById(int id) async{
        return null;
    }

    Future<List<WCProduct>> getProductsByCategory(String category, [List<ApiParam> params]) async{
        if(params == null)
            params = [];
        
        int c;
        if(categories.containsKey(category))
            c = categories[category];
        else 
            c = 19;

        params.add(new ApiParam(param: 'category', value: c.toString()));
        var response = await client.getWC('products', params);

        List<WCProduct> result = [];
        JSON.decode(response).forEach((r){
            result.add(new WCProduct()..fromJson(r));
        });

        return result;
    }

    Future<List<WCProduct>> getProducts(int page, [int perPage = 20]) async{
        var response = await client.getWC('products', [new ApiParam(param: 'page', value: page.toString())]);

        if(response == null) return null;

        List<WCProduct> result = [];
        JSON.decode(response).forEach((p){
            result.add(new WCProduct()..fromJson(p));
        });

        return result;
    }
}