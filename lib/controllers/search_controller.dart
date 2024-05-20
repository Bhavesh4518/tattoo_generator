import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MySearchController extends GetxController {
  var isSearching = false.obs;
  TextEditingController searchController = TextEditingController();
  var searchResults = <Map<String, dynamic>>[].obs;
  var tattooData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTattooData();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      searchResults.clear();
    }
  }

  Future<void> fetchTattooData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Tattoo').get();
    tattooData.value = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void searchTattoo(String query) {
    if (query.isEmpty) {
      searchResults.clear();
    } else {
      searchResults.value = tattooData
          .where((tattoo) => tattoo['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
