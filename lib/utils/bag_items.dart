import 'package:kurdistan_food_network/models/internal/bag_item.dart';
import 'package:kurdistan_food_network/models/product_response.dart';

List<BagItem> bagItems = [];

bool addProductToBag(String priceId, ProductResponse product) {
  if (bagItems.isNotEmpty) {
    var item = bagItems.first;

    if (item.product.producerId != product.producerId) {
      return false;
    }
  }

  bagItems.add(BagItem(priceId: priceId, product: product));
  return true;
}

void removeProductFromBag(String productId) {
  bagItems.removeWhere((element) => element.product.id == productId);
}
