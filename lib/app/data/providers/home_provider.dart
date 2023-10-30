import 'package:get/get.dart';
import 'package:task_app/app/data/models/category_model.dart';
import 'package:task_app/app/data/models/nearby_service_model.dart';
import '../api_config.dart';

class HomeProvider extends GetConnect {
  void onInit() {}
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      String getUrl = ApiConfig.getCategory;
      Response response = await get(getUrl);
      if (response.statusCode == 200) {
        return categoryModelFromJson(response.body["categories"]);
      }
    } catch (exception) {
      print('$exception');
    }
    return [];
  }

  Future<List<NearbyServiceModel>> getAllNearbyService() async {
    try {
      String getUrl = ApiConfig.getNearbyService;
      Response response = await get(getUrl);
      if (response.statusCode == 200 && response.body["status"] == 200) {
        return nearbyServiceModelFromJson(response.body["nearbyservices"]);
      }
    } catch (exception) {
      print('$exception');
    }
    return [];
  }
}
