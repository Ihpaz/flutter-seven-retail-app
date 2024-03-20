import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seven_retail/page/payment.dart';
import 'package:seven_retail/widget/profile.dart';

import '../controller/currency_format.dart';
import '../controller/homecontroller.dart';
import 'home.dart';


class Cart extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    Widget BodyDetail(){
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Icon(Icons.add_shopping_cart_sharp),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Keranjang makananmu masih kosong..'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Silahkan tambahkan menu..'),
                )
              ]
          )
      );
    }



    Widget BodyDetails(){
      return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height:MediaQuery
              .of(context)
              .size
              .height ,
          child: Column(
              children:[
                ProfileWidget().profileWidget(context),
                Container(
                  padding: EdgeInsets.only(left:5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('wajib untuk mengisi data',style: TextStyle(color: Colors.red,fontSize: 10),) ,
                  )

                ),
                Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                  child: Center(child:Text('Your Order',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
                ),
                Container(
                    height: 250,
                    child:ListView.builder(
                        padding: const EdgeInsets.all(5),
                        itemCount: c.dtMenuOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 100,
                              color: Colors.amber[100],
                              child:
                              Row(
                                children: [

                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * (25 / 100),
                                      height: 100,
                                      child: Image.asset(c.dtMenuOrder[index].url,
                                        height: 100, width: 100, fit: BoxFit.fill,)
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (47 / 100),
                                        height: 20,
                                        child: Text(c.dtMenuOrder[index].nama, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                      ),

                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (47 / 100),
                                        height: 50,
                                        child: Text('Notes :'+c.dtMenuOrder[index].notes),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (20 / 100),
                                        height: 20,
                                        child: Text("Qty. "+'${c.dtMenuOrder[index].qty}', style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * (20 / 100),
                                          height: 20,
                                          child: Text(CurrencyFormat.convertToIdr(c.dtMenuOrder[index].totalHargaQty,0),
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (20 / 100),
                                        height: 30,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            c.dtMenuOrder.removeAt(index);
                                            c.getTotal();
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                            ),

                                          ),
                                        ),
                                      )
                                    ],
                                  )


                                ],
                              )
                          );
                        }
                    )
                ),
                Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * (70 / 100),
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.lightGreen),
                    onPressed: () {
                      c.getGrndTotal();
                      Get.to(()=>Payment());
                    },
                    child: Text(
                      "Submit Order | "'${CurrencyFormat.convertToIdr(c.hargaTotal.value,0)}',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                )
              ]

          ),

        ),
      );
    }

    return Obx(()=>
        Scaffold(
          appBar:new AppBar(
            title: Text('Cart'),
            backgroundColor: Color(0xffA70E61),
          ) ,
          backgroundColor: Color(0xffE5E5E5),
          body:c.dtMenuOrder.length == 0 ? BodyDetail():BodyDetails(),
        ),
    );


  }





}

