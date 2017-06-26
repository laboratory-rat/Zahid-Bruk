import 'JsonObject.dart';

class StorageItem<T extends JsonObject> extends JsonObject{
    DateTime time;
    T item;
}