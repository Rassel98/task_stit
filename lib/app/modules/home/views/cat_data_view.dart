import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/category_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';
import '../../../data/api_config.dart';

class CategoryDataList extends StatelessWidget {
  const CategoryDataList({Key? key, required this.categoryModel}) : super(key: key);
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.getServiceByCategory(servicecategoryId: categoryModel.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.name.toString()),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Obx(
        () => controller.shortedNearbyServiceList.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No data found",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.getAllNearbyServiceData();
                        controller.getServiceByCategory(servicecategoryId: categoryModel.id.toString());
                      },
                      child: const Text(
                        "Sync",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: controller.shortedNearbyServiceList.length,
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final model = controller.shortedNearbyServiceList[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10),
                      //   side: const BorderSide(color: Colors.black),
                      // ),
                      leading: CachedNetworkImage(
                        imageUrl: ApiConfig.baseUrl + model.img.toString(),
                        placeholder: (context, url) => const Icon(Icons.network_cell_outlined),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        width: 40,
                        height: 40,
                      ),
                      style: ListTileStyle.list,
                      title: Text(
                        model.name ?? "",
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, overflow: TextOverflow.ellipsis, color: Colors.black),
                      ),
                      subtitle: Text(
                        model.servicename ?? "",
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis, fontSize: 13, color: Colors.black54),
                      ),
                      trailing: Text(
                        model.number ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
