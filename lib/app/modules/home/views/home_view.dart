import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/api_config.dart';
import 'package:task_app/app/data/models/category_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              )
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: controller.nearbyServiceList.isEmpty && controller.categoryList.isEmpty
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
                                controller.getAllNearbyServiceData();
                                controller.getAllCategoryData();
                              },
                              child: const Text(
                                "Sync",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                    )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Category :",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.categoryList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9),
                            itemBuilder: (context, index) {
                              CategoryModel model = controller.categoryList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Ink(
                                    // padding: const EdgeInsets.only(top: 14, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xffD4D5D6).withOpacity(0.7),
                                          spreadRadius: 0,
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 10,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                          child: CachedNetworkImage(
                                            imageUrl: ApiConfig.baseUrl + model.imgUrl.toString(),
                                            placeholder: (context, url) => const Icon(Icons.network_cell_outlined),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Text(
                                          model.name.toString(),
                                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Nearby Service :",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            itemCount: controller.nearbyServiceList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final model = controller.nearbyServiceList[index];
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
                          Visibility(
                            visible: controller.nearbyServiceList.isEmpty,
                            child: SizedBox(
                              height: Get.height * 0.55084,
                            ),
                          )
                        ],
                      ),
              ),
      ),
    );
  }
}
