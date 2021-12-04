import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled/constants/firebase.dart';
import 'package:untitled/models/product.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((query) => query.docs
          .map(
              (QueryDocumentSnapshot item) => ProductModel.fromMap(item.data()))
          .toList());
}
