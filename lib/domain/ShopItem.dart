import '../src/JsonObject.dart';

class ShopItem extends JsonObject
{ 
    String id;
    String title;
    String description;
    List<String> imageUrls;

    ShopItem({this.id, this.title, this.description, this.imageUrls}){}

    ShopItem.oneImage(String id, String title, String description, String imageUrl)
    {
        this.id = id;
        this.title = title;
        this.description = description;
        this.imageUrls = new List<String>()..add(imageUrl);
    }

    ShopItem.clear()
    {
        imageUrls = new List<String>();
        title = '';
        description = '';
        id = '';
    }

    ShopItem.Map(dynamic s)
    {
        id = s['id'];
        title = s['title'];
        description = s['description'];
        imageUrls = s['imageUrls'];
    }
}