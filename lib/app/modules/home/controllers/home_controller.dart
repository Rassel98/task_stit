import 'package:get/get.dart';
import 'package:task_app/app/data/models/category_model.dart';
import 'package:task_app/app/data/models/nearby_service_model.dart';
import 'package:task_app/app/data/providers/home_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var isLoading = true.obs;

  final _categoryList = <CategoryModel>[].obs;
  List<CategoryModel> get categoryList => _categoryList;

  final _nearbyServiceList = <NearbyServiceModel>[].obs;
  List<NearbyServiceModel> get nearbyServiceList => _nearbyServiceList;

  Rx<List<NearbyServiceModel>> _shortedNearbyServiceList = Rx<List<NearbyServiceModel>>([]);
  List<NearbyServiceModel> get shortedNearbyServiceList => _shortedNearbyServiceList.value;
  @override
  void onInit() async {
    super.onInit();
    await getAllCategoryData();
    await getAllNearbyServiceData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllCategoryData() async {
    try {
      var getResponse = await HomeProvider().getAllCategory();
      if (getResponse != []) {
        _categoryList.value = getResponse;
      } else {
        print('do not comming data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getAllNearbyServiceData() async {
    try {
      var getResponse = await HomeProvider().getAllNearbyService();
      if (getResponse != []) {
        _nearbyServiceList.value = getResponse;
        print(nearbyServiceList.length);
        isLoading(false);
      } else {
        print('do not comming data');
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading(false);
  }

  void getServiceByCategory({required String servicecategoryId}) {
    _shortedNearbyServiceList.value=[];
    _shortedNearbyServiceList.value =
        nearbyServiceList != [] ? nearbyServiceList.where((element) => element.servicecategoryId.toString() == servicecategoryId.toString()).toList() : [];
  }
}
