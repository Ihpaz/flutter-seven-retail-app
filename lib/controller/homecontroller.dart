

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var changeSelectedNavBar=0.obs;
  var textHeader="NBRS MEMBER".obs;
  var isLoading=false.obs;
  var hargaTotal=0.obs;
  var dtProduct =<MenuModel>[].obs;
  var dtContProduct=<MenuModel>[].obs;
  var dtProductDetail =<MenuModel>[].obs;
  var currentQty=0.obs;
  var currentNotes=''.obs;
  var isCheckedMeat=false.obs;
  var isCheckedEgg=false.obs;
  var totalHargaQty=0.obs;



  var tot=0.obs;

  var isCheckedGopay=false.obs;
  var isCheckedBankTransfer=false.obs;
  var isCheckedDebit=false.obs;


  var isOnlinePayment=true.obs;
  var isPayAtCahsier=false.obs;


  var paymentMethod=''.obs;
  var filterMenu=''.obs;
  var dtMenuOrder=<MenuOrderModel>[].obs;


  @override
  void onInit() {
    addProduct();
    print(dtProduct);
    super.onInit();
  }

  addProduct(){
    final List<dynamic> decodedData = [
      {"id":0,"url":"assets/product.jpeg","harga":50000,"nama":"Golden Lamian 1","deskripsi":"1 lorem ipsum dolor sit amet consectetur adipiscing elit 1"},
      {"id":1,"url":"assets/product2.jpeg","harga":60000,"nama":"Golden Lamian 2","deskripsi":"2 lorem ipsum dolor sit amet consectetur adipiscing elit 2"},
      {"id":2,"url":"assets/product3.jpeg","harga":70000,"nama":"Golden Lamian 3","deskripsi":"3 lorem ipsum dolor sit amet consectetur adipiscing elit 3"},
      {"id":3,"url":"assets/product4.jpeg","harga":80000,"nama":"Golden Lamian 4","deskripsi":"4 lorem ipsum dolor sit amet consectetur adipiscing elit 4"},
      {"id":4,"url":"assets/product5.jpeg","harga":90000,"nama":"Golden Lamian 5","deskripsi":"5 lorem ipsum dolor sit amet consectetur adipiscing elit 5"}]; // Get the decoded response data

    var data= decodedData.map((e) =>
    new MenuModel.fromJson(e)).toList();

    dtProduct.clear();
    dtContProduct.clear();
    dtProduct.addAll(data);
    dtContProduct.addAll(data);
  }
  changeNavBar(int no){
    changeSelectedNavBar.value=no;

    if(no==1){
      textHeader.value ="PROFILE MEMBER";
    }else{
      textHeader.value ="NBRS MEMBER";
    }
  }

  getProductByid(int id)  {
    var result = [ dtProduct[id]];
    print(result);
    dtProductDetail.addAll(result);

  }

  addMenuORder(int id){
    var data={'notes':currentNotes.value,'qty':currentQty.value,'totalHargaQty':totalHargaQty.value};

    var dt=dtContProduct[id].toMap();
    Map<String, dynamic> result = {};
    result.addAll(dt);
    result.addAll(data);

    MenuOrderModel orders=MenuOrderModel.fromMap(result);

    dtMenuOrder.add(orders);
  }

  void getTotal (){
    hargaTotal.value=0;

    for (var dt in dtMenuOrder) {
      hargaTotal=hargaTotal+dt.totalHargaQty;
    }
  }

  void getGrndTotal (){
    tot.value=0;

    tot.value=hargaTotal.value.toInt()+10000;
    print(tot.value);
  }

  SearcMenu() async{
    isLoading.value= true;
    print(filterMenu.value);
    List<MenuModel> dtProductnew  =dtContProduct.where((product) => product.nama.contains(filterMenu.value)).toList();
    dtProduct.clear();

    if(dtProductnew.length > 0 &&  filterMenu.value!=''){
      dtProduct.addAll(dtProductnew);
    }else{
      Fluttertoast.showToast(
          msg: "Menu tidak ditemukan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFFE57373),
          textColor: Colors.white,
          fontSize: 16.0
      );
      dtProduct.addAll(dtContProduct);
    }

    await Future.delayed(Duration(seconds: 1), () {
      // This code will run after 2 seconds
      print('Two seconds have passed');
      isLoading.value= false;
      print(isLoading.value);
    });

  }

  resetAll(){
    dtMenuOrder.clear();
    isCheckedBankTransfer.value=false;
    isCheckedDebit.value=false;
    isCheckedGopay.value=false;
  }
}

class MenuModel {
  int id;
  String url;
  String nama;
  int harga;
  String deskripsi;


  MenuModel({
    required this.id,
    required this.url,
    required this.nama,
    required this.deskripsi,
    required this.harga
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'nama':nama,
      'deskripsi':deskripsi,
      'harga':harga
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson){
    return MenuModel(
        id        : parsedJson['id'],
        url     : parsedJson['url'],
        nama      : parsedJson['nama'],
        deskripsi     : parsedJson['deskripsi'],
        harga: parsedJson['harga']
    );
  }
}

class MenuOrderModel {
  int id;
  String url;
  String nama;
  int harga;
  String deskripsi;
  String notes;
  int qty;
  int totalHargaQty;


  MenuOrderModel({
    required this.id,
    required this.url,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.notes,
    required this.qty,
    required this.totalHargaQty,
  });

  factory MenuOrderModel.fromJson(Map<String, dynamic> parsedJson){
    return MenuOrderModel(
        id        : parsedJson['id'],
        url     : parsedJson['url'],
        nama      : parsedJson['nama'],
        deskripsi     : parsedJson['deskripsi'],
        harga: parsedJson['harga'],
        notes: parsedJson['notes'],
        qty: parsedJson['qty'],
        totalHargaQty: parsedJson['totalHargaQty'],
    );
  }

  factory MenuOrderModel.fromMap(Map<String, dynamic> map){
    return MenuOrderModel(
      id        : map['id'],
      url     : map['url'],
      nama      : map['nama'],
      deskripsi     : map['deskripsi'],
      harga: map['harga'],
      notes: map['notes'],
      qty: map['qty'],
      totalHargaQty: map['totalHargaQty'],
    );
  }
}